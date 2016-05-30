package com.newenv.lpzd.lp.service;

import com.newenv.lpzd.lp.dao.LpContractRecordDao;
import com.newenv.lpzd.lp.dao.LpFanghaoInfoSyncTimer;
import com.newenv.lpzd.lp.domain.HouseSourceKey;
import com.newenv.lpzd.lp.domain.TaskData;

public class LpContractRecordService {

	private LpContractRecordDao lpContractRecordDao;
	
	private LpFanghaoInfoSyncTimer lpFanghaoInfoSyncTimer;
	
	/**
	 * 同步BMS成交信息。
	 * @param houseType
	 * @param contractId
	 */
	public void syncInfo(Integer houseType, Integer contractId){
		lpFanghaoInfoSyncTimer.offer(new TaskData(2,new HouseSourceKey(houseType,contractId)));
	}

	public LpContractRecordDao getLpContractRecordDao() {
		return lpContractRecordDao;
	}

	public void setLpContractRecordDao(LpContractRecordDao lpContractRecordDao) {
		this.lpContractRecordDao = lpContractRecordDao;
	}

	public LpFanghaoInfoSyncTimer getLpFanghaoInfoSyncTimer() {
		return lpFanghaoInfoSyncTimer;
	}

	public void setLpFanghaoInfoSyncTimer(
			LpFanghaoInfoSyncTimer lpFanghaoInfoSyncTimer) {
		this.lpFanghaoInfoSyncTimer = lpFanghaoInfoSyncTimer;
	}
	
}
