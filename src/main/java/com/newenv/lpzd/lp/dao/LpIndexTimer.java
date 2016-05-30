package com.newenv.lpzd.lp.dao;

import java.util.Queue;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentLinkedQueue;

import com.newenv.lpzd.Utils.HttpClientUtil;


/**
 * 划盘时给楼盘建索引的定时器。
 * @author chenky
 *
 */
public class LpIndexTimer {

	private static LpIndexTimerTask timerTask = null;
	private String bmsBaseUrl = "";
	
	public LpIndexTimer(){
		Timer timer = new Timer();
		timerTask = new LpIndexTimerTask();
		timer.schedule(timerTask, 10000 , 30000);	//每30秒检测一次
	}
	
	public void offer(Integer lpId){
		timerTask.offer(lpId);
	}

	public String getBmsBaseUrl() {
		return bmsBaseUrl;
	}

	public void setBmsBaseUrl(String bmsBaseUrl) {
		this.bmsBaseUrl = bmsBaseUrl;
		timerTask.setBmsBaseUrl(bmsBaseUrl);
	}
}

class LpIndexTimerTask extends TimerTask {
	
	private Queue<Integer> lpQueue = new ConcurrentLinkedQueue<Integer>();
	
	private String bmsBaseUrl = "";
	
	private boolean idle = true;	//是否空闲
	
	public LpIndexTimerTask(){
		
	}
	
	@Override
	public void run() {
		if(idle){
			idle = false;
			while(!lpQueue.isEmpty()){
				Integer lpId = lpQueue.poll();
				try {
					HttpClientUtil.getInstance().httpGet(bmsBaseUrl + "/pages/house/doLpUpdateIndex.action?houseSource.lpId="+lpId, "UTF-8");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			idle = true;
		}
	}

	public void offer(Integer lpId){
		this.lpQueue.offer(lpId);
	}

	public String getBmsBaseUrl() {
		return bmsBaseUrl;
	}

	public void setBmsBaseUrl(String bmsBaseUrl) {
		this.bmsBaseUrl = bmsBaseUrl;
	}
	
}
