package com.newenv.lpzd.lp.dao;

import java.util.Queue;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentLinkedQueue;

import com.newenv.base.bigdata.dao.DAOConstants;
import com.newenv.lpzd.lp.domain.HouseSourceKey;
import com.newenv.lpzd.lp.domain.TaskData;


/**
 * 楼盘房号信息同步的定时器。
 * @author chenky
 *
 */
public class LpFanghaoInfoSyncTimer {

	private static LpFanghaoInfoSyncTimerTask timerTask = null;
	private XhjLpfanghaoDao xhjLpfanghaoDao;
	private LpContractRecordDao lpContractRecordDao;
	private long period = 1800000;	//默认每30分钟检测一次
	
	public LpFanghaoInfoSyncTimer(){
		timerTask = new LpFanghaoInfoSyncTimerTask();
	}
	
	public void offer(TaskData data){
		timerTask.offer(data);
	}

	public long getPeriod() {
		return period;
	}

	public void setPeriod(long period) {
		this.period = period * 60 * 1000;
		Timer timer = new Timer();
		timer.schedule(timerTask, 10000 , period);	
	}

	public void setXhjLpfanghaoDao(XhjLpfanghaoDao xhjLpfanghaoDao) {
		this.xhjLpfanghaoDao = xhjLpfanghaoDao;
		timerTask.setXhjLpfanghaoDao(xhjLpfanghaoDao);
	}

	public void setLpContractRecordDao(LpContractRecordDao lpContractRecordDao) {
		this.lpContractRecordDao = lpContractRecordDao;
		timerTask.setLpContractRecordDao(lpContractRecordDao);
	}
	
	
}

class LpFanghaoInfoSyncTimerTask extends TimerTask {
	
	private Queue<TaskData> houseSourceQueue = new ConcurrentLinkedQueue<TaskData>();
	private XhjLpfanghaoDao xhjLpfanghaoDao;
	private LpContractRecordDao lpContractRecordDao;
	
	private boolean idle = true;	//是否空闲
	
	public LpFanghaoInfoSyncTimerTask(){
		
	}
	
	@Override
	public void run() {
		if(idle){
			idle = false;
			while(!houseSourceQueue.isEmpty()){
				TaskData taskData = houseSourceQueue.poll();
				try {
					switch(taskData.getDataType()){
						case 1:	//房源
							xhjLpfanghaoDao.syncInfo((HouseSourceKey)taskData.getData(), DAOConstants.RELATIONAL);
							break;
						case 2:	//成交
							HouseSourceKey contractInfo = (HouseSourceKey)taskData.getData();
							lpContractRecordDao.syncInfo(contractInfo.getHouseType(), contractInfo.getSaleOrRentId(), DAOConstants.RELATIONAL);
							break;
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			idle = true;
		}
	}

	public void offer(TaskData data){
		this.houseSourceQueue.offer(data);
	}

	public void setXhjLpfanghaoDao(XhjLpfanghaoDao xhjLpfanghaoDao) {
		this.xhjLpfanghaoDao = xhjLpfanghaoDao;
	}

	public void setLpContractRecordDao(LpContractRecordDao lpContractRecordDao) {
		this.lpContractRecordDao = lpContractRecordDao;
	}
	
}
