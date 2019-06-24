Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EEA5051F
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 11:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfFXJGL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 05:06:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57434 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXJGK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 05:06:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O949Vk149094;
        Mon, 24 Jun 2019 09:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=UsJ7/y/cLqh/pltGuIkUX4yW5joUxJdaV2InzqpTWzY=;
 b=lUinhVggQwvlCmdiqzKPWSVCuigbxqCzK2NxrVbx7INjbCraGG5UVgZXmqSecN/jHWf7
 QMDLULiMZyvCD9VljqW1XCXl+wO4x7g/OEO3lJS3T2Ar2aHZrl5tHaJZraIeIY4cV0cu
 WmdGJylAUYjeT6sE3eB8RaF+7uLXzLKo8KKPSo4Xvz26p25xfNiBN2cGt9O9R5fwgV4p
 C51/cwINET9Nqgfn3ZCjt0HLcyQKPhUZRwruN4pbJ2Y3dD4SFQ0VUJQyfoNh7GQg2oTl
 GOf8sFWFGCUCd1chRGeGLtXnB8/pXzz/04o24xhSxW6AwtVtkFXCvAHNXrGHiIH/kGF9 nQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brsw71d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 09:06:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O95Qua110570;
        Mon, 24 Jun 2019 09:06:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t9acbd6fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 09:06:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5O9641D010964;
        Mon, 24 Jun 2019 09:06:05 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 02:06:04 -0700
Date:   Mon, 24 Jun 2019 12:05:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: Re: [PATCH v2 17/18] megaraid_sas: Introduce various Aero
 performance modes
Message-ID: <20190624090555.GP18776@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620105208.15011-18-chandrakanth.patil@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240076
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Chandrakanth,

url:    https://github.com/0day-ci/linux/commits/Chandrakanth-Patil/megaraid_sas-driver-updates-to-07-710-06-00-rc1/20190621-003611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/scsi/megaraid/megaraid_sas_base.c:6031 megasas_init_fw() warn: curly braces intended?

Old smatch warnings:
drivers/scsi/megaraid/megaraid_sas_base.c:1883 megasas_set_dynamic_target_properties() warn: if statement not indented
drivers/scsi/megaraid/megaraid_sas_base.c:3445 megasas_complete_cmd() error: we previously assumed 'cmd->scmd' could be null (see line 3412)
drivers/scsi/megaraid/megaraid_sas_base.c:6015 megasas_init_fw() error: we previously assumed 'fusion' could be null (see line 5914)

# https://github.com/0day-ci/linux/commit/0020c0465179c06d4dac82747eeffccc59b9a6e4
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 0020c0465179c06d4dac82747eeffccc59b9a6e4
vim +6031 drivers/scsi/megaraid/megaraid_sas_base.c

0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6018  			/*
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6019  			 * Performance mode settings provided through module parameter-perf_mode will
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6020  			 * take affect only for:
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6021  			 * 1. Aero family of adapters.
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6022  			 * 2. When user sets module parameter- perf_mode in range of 0-2.
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6023  			 */
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6024  			if ((perf_mode >= MR_BALANCED_PERF_MODE) &&
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6025  				(perf_mode <= MR_LATENCY_PERF_MODE))
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6026  				instance->perf_mode = perf_mode;
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6027  			/*
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6028  			 * If intr coalescing is not supported by controller FW, then IOPs
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6029  			 * and Balanced modes are not feasible.
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6030  			 */
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20 @6031  				if (!intr_coalescing)

This if statement is indented as if it's part of the earlier condition
but the comments aren't so it's not clear what was intended.

0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6032  					instance->perf_mode = MR_LATENCY_PERF_MODE;
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6033  
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6034  		}
ea76a259b5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6035  
0020c04651 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6036  		if (instance->perf_mode == MR_BALANCED_PERF_MODE)
ea76a259b5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6037  			instance->low_latency_index_start =
ea76a259b5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6038  				MR_HIGH_IOPS_QUEUE_COUNT;
ea76a259b5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6039  		else
ea76a259b5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6040  			instance->low_latency_index_start = 1;
ea76a259b5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6041  
ea76a259b5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-20  6042  		num_msix_req = num_online_cpus() + instance->low_latency_index_start;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
