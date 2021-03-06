package com.zs.action.da;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import net.sf.json.JSONArray;

import com.zs.action.IMyBaseAction;
import com.zs.action.MyBaseAction;
import com.zs.entity.DaCount;
import com.zs.entity.DaDemand;
import com.zs.service.IService;
import com.zs.tools.Page;
import com.zs.tools.WeekDateArea;

public class DaCountAction extends MyBaseAction implements IMyBaseAction{

	IService ser;
	Page page;
	
	
	List<DaCount> counts;
	
	String filtrate;
	
	String result="count";
	String result_succ="succ";
	String result_fail="fail";
	
	String dates;
	String datee;
	String id;
	String cz;
	
	Logger logger=Logger.getLogger(DaCountAction.class);
//----------------------------------------------------	
	
	public IService getSer() {
		return ser;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCz() {
		return cz;
	}
	public void setCz(String cz) {
		this.cz = cz;
	}
	public String getFiltrate() {
		return filtrate;
	}
	public void setFiltrate(String filtrate) {
		this.filtrate = filtrate;
	}
	public List<DaCount> getCounts() {
		return counts;
	}
	public void setCounts(List<DaCount> counts) {
		this.counts = counts;
	}
	public void setSer(IService ser) {
		this.ser = ser;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public String getDates() {
		return dates;
	}
	public void setDates(String dates) {
		this.dates = dates;
	}
	public String getDatee() {
		return datee;
	}
	public void setDatee(String datee) {
		this.datee = datee;
	}
	//----------------------------------------------------
	public void clearOptions() {
		page=null;
		dates=null;
		datee=null;
		filtrate=null;
		cz=null;
		if (page==null) {
			page=new Page(1, 0, 10);
		}else {
			page.setPageOn(1);
		}
	}
	private void clearSpace() {
		if (filtrate!=null && !filtrate.equals("")) {
			filtrate=filtrate.trim();
		}else {
			filtrate="D";
		}
		if (dates!=null) {
			dates=dates.trim();
		}
		if (datee!=null) {
			datee=datee.trim();
		}
	}
	
	
	/**
	 * 组装count
	 */
	private void initCount(Date dateStart,Date dateEnd,List counts) {
		//组装一个DaCount
		DaCount count=new DaCount();
		count.setsTime(new Timestamp(dateStart.getTime()));
		count.seteTime(new Timestamp(dateEnd.getTime()));
		//获取在该时间范围内故障报修总量
		List list2=ser.find("from DaDemand where DTime>=? and DTime<=?", new Timestamp[]{count.getsTime(),count.geteTime()});
		if (list2.size()!=0) {//如果为0就不要了
			count.setDaAll(list2.size());
			//获取在该时间范围内故障报修完成的量
			List list3=ser.find("from DaDemand where DTime>=? and DTime<=? and DId in (select DId from DaPerform where PState='已完成')", new Timestamp[]{count.getsTime(),count.geteTime()});
			count.setDaSuc(list3.size());
			//计算完成率
			if (list2.size()==0) {
				count.setRatioSuc(0);
			}else {
				double ratio=(double)list3.size()/(double)list2.size()*100;
				count.setRatioSuc((int)ratio);
			}
			//设置DemPer
			if(list2.size()>0){
				List list4=ser.initDemPers(list2);
				count.setDemPer(list4);
			}
			counts.add(count);
		}
	}
	
	/**
	 * 组装counts
	 * @param counts
	 * @param dt
	 * @throws ParseException
	 */
	private void initCounts(List<DaCount> counts,String dt) throws ParseException {
		//获取两个头尾的时间
//		logger.debug(dates);
//		logger.debug(datee);
		DaDemand d1 = null,d2=null;
		String str="from DaDemand where DTime!=null ";
		String str1="from DaDemand where DTime!=null ";
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		if((dates==null||dates.equals(""))&&(datee==null||datee.equals(""))){
			Date d = new Date();
			if(dt.equals("D")){
				datee =	new SimpleDateFormat("yyyy-MM-dd").format(new Date(d.getYear(), d.getMonth(),d.getDate()+1));
				dates =	new SimpleDateFormat("yyyy-MM-dd").format(new Date(d.getYear(), d.getMonth(),d.getDate()-7));
			}
			if(dt.equals("W")){
				datee =	new SimpleDateFormat("yyyy-MM-dd").format(new Date(d.getYear(), d.getMonth(),d.getDate()+1));
				dates =	new SimpleDateFormat("yyyy-MM-dd").format(new Date(d.getYear(), d.getMonth(),d.getDate()-7));
			}
			if(dt.equals("M")){
				datee =	new SimpleDateFormat("yyyy-MM").format(new Date(d.getYear(), d.getMonth(),d.getDate()));
				dates =	new SimpleDateFormat("yyyy-MM").format(new Date(d.getYear(), d.getMonth()-1,d.getDate()));
			}
			
		}
		if(dates!=null && !dates.equals("")){
			if(dt.equals("D")||dt.equals("M")||dt.equals("Y")){
				str1=str1+" and DTime >='"+dates+"'";
			}
			if(dt.equals("W")){
				List datelist = WeekDateArea.weekdate(dates, datee);
				str1=str1+" and DTime >='"+datelist.get(1)+"'";
			}
			
		}
		if(datee!=null && !datee.equals("")){
			if(dt.equals("D")){
				str=str+" and DTime <='"+datee+"'";
			}
			if(dt.equals("W")){
				List datelist = WeekDateArea.weekdate(dates, datee);
				str=str+" and DTime <='"+datelist.get(0)+"'";
			}
			if(dt.equals("M")){
				Date edate = new Date(Integer.parseInt(datee.substring(0,4))-1900, Integer.parseInt(datee.substring(5)),0);
				str=str+" and DTime <='"+sdf.format(edate)+"'";
			}
			if(dt.equals("Y")){
				Date edate = new Date(Integer.parseInt(datee)-1900, 12,0);
				str=str+" and DTime <='"+sdf.format(edate)+"'";
			}
		}
		str=str+" order by DTime desc";
		List list=ser.query(str, null, str, page, ser);
		if (list.size()>0) {
			d1=(DaDemand) list.get(0);//尾巴
		}
		str1=str1+" order by DTime asc";
		list=ser.query(str1, null, str1, page, ser);
		if (list.size()>0) {
			d2=(DaDemand) list.get(0);//头
		}
		if (d1!=null && d2!=null) {
			if (dt.equals("D")) {
				//获取相差天数
				Date date1=sdf.parse(d1.getDTime().toLocaleString());
				Date date2=sdf.parse(d2.getDTime().toLocaleString());
				long days=(date1.getTime()-date2.getTime())/(1000*3600*24);
				/*
				logger.debug(date1.toLocaleString()+" "+date2.toLocaleString());
				logger.debug(d1.getDTime().toLocaleString()+" "+d2.getDTime().toLocaleString());
				logger.debug(d1.getDTime().getDate());
				*/
				//从第一天开始循环组装数据封装
				for (int i = 0; i <=days; i++) {
					Date dateStart=new Date(d1.getDTime().getYear(), d1.getDTime().getMonth(), d1.getDTime().getDate()-i,0,0,0);
					Date dateEnd=new Date(d1.getDTime().getYear(), d1.getDTime().getMonth(), d1.getDTime().getDate()-i,23, 59, 59);
					initCount(dateStart, dateEnd, counts);
				}
			}else if (dt.equals("W")) {
				int weeknum =(int)((d1.getDTime().getTime()-d2.getDTime().getTime())/(1000*60*60*24))/7;
				for (int i = 0; i <= weeknum; i++) {
					Date date = new Date(d1.getDTime().getYear(),d1.getDTime().getMonth(),d1.getDTime().getDate()-(7*i));
					Date dateStart= ser.weekDate(date).get(ser.KEY_DATE_START);
					Date dateEnd=ser.weekDate(date).get(ser.KEY_DATE_END);
					Calendar ca3 = Calendar.getInstance();
					ca3.setTime(dateStart);
					initCount(dateStart, dateEnd, counts);
				}
			}else if (dt.equals("M")) {
				//获取相差月数
				long ms=(d1.getDTime().getYear()-d2.getDTime().getYear())*12+(d1.getDTime().getMonth()-d2.getDTime().getMonth());
				//logger.debug(ms);
				for (int i = 0; i <= ms; i++) {
					Date dateStart=new Date(d1.getDTime().getYear(), d1.getDTime().getMonth()-i, 1,0,0,0);
					Calendar ca = Calendar.getInstance();    
					ca.set(1900+d1.getDTime().getYear(), 1+d1.getDTime().getMonth()-i, 0);
					Date dateTmp=ca.getTime();
					//logger.debug(dateTmp.toLocaleString()+"  "+d2.getDTime().getYear()+"  "+d2.getDTime().getMonth());
					Date dateEnd=new Date(dateTmp.getYear(), dateTmp.getMonth(), dateTmp.getDate(),23,59,59);
					initCount(dateStart, dateEnd, counts);
				}
			}else if (dt.equals("Y")) {
				//获得相差年数
				long ys=d1.getDTime().getYear()-d2.getDTime().getYear();
				for (int i = 0; i <= ys; i++) {
					Date dateStart=new Date(d1.getDTime().getYear()-i, 0, 1,0,0,0);
					Date dateEnd=new Date(d1.getDTime().getYear()-i, 11, 31,23,59,59);
					initCount(dateStart, dateEnd, counts);
				}
			}
		}
	}
	
	
	public String queryOfFenye() throws UnsupportedEncodingException {
		if (cz!=null && cz.equals("yes")) {
			clearOptions();
		}
		clearSpace();
		counts=new ArrayList<DaCount>();
		if(id!=null){
			/*
			由于是统计模块所以不需要按编号查询功能，但为了兼容，故保留，只不过其代码为空而已。
			*/
		}else {
			try {
				initCounts(counts,filtrate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		JSONArray json=JSONArray.fromObject(counts);
		getRequest().setAttribute("json", json);
		return result;
	}
	
	
	public String gotoQuery() throws UnsupportedEncodingException {
		// TODO Auto-generated method stub
		return result;
	}
	
	
	public String add() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	

}
