Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239B056241
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2019 08:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfFZGUi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 02:20:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45210 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZGUi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 02:20:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q6J7Hf087362;
        Wed, 26 Jun 2019 06:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=joic+JzCF5IIgZhWSykEF8wfxPdf0QYYryCk1+Ww6Ug=;
 b=0rGsBXQ0gSPof2p8wIKDiRLllMISx7DuArA8Ef2Iqx9GYkYsBDrwiHNsCVfTvrmSBSvZ
 y8HeeuCZQLZCcO0aNmEAly/A5rLuYZCPhwhoW+1sVxzjh4jUFqnPYOtibHX3JEJOJyF1
 dwyKLUGy/Ucf2KPKvTb5KNlxYH4+PLW5CrVwKWjH7wPJIMhp/Nemlc3SjVyn/DjuXjkN
 5Z1F3C028KPlANhGIUBta8EVY+olos/7T3UtVL11KV2V9hUhvTqA3+fp1Q3PxfZHemY9
 yHDEgvlSjCxSLaVKDIC1B5EOkmMw5PFKsR918+3AIMxFgkaE3SCemAoudPdknPMhrq/l qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t9cyqg6pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 06:20:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q6JWnm137560;
        Wed, 26 Jun 2019 06:20:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tat7cn4jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 06:20:33 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5Q6KV0P027054;
        Wed, 26 Jun 2019 06:20:32 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 23:20:30 -0700
Date:   Wed, 26 Jun 2019 09:20:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Himanshu Madhani <hmadhani@marvell.com>
Cc:     kbuild-all@01.org, James.Bottomley@HansenPartnership.com,
        martin.petersen@oracle.com, hmadhani@marvell.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 2/3] qla2xxx: on session delete return nvme cmd
Message-ID: <20190626062022.GB18776@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618181021.16547-3-hmadhani@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260075
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Himanshu,

url:    https://github.com/0day-ci/linux/commits/Himanshu-Madhani/qla2xxx-Fix-crashes-with-FC-NVMe-devices/20190619-074559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/scsi/qla2xxx/qla_nvme.c:245 qla_nvme_ls_req() warn: variable dereferenced before check 'fcport' (see line 242)
drivers/scsi/qla2xxx/qla_nvme.c:496 qla_nvme_post_cmd() warn: variable dereferenced before check 'fcport' (see line 494)
drivers/scsi/qla2xxx/qla_nvme.c:510 qla_nvme_post_cmd() error: we previously assumed 'qpair' could be null (see line 496)

Old smatch warnings:
drivers/scsi/qla2xxx/qla_nvme.c:190 qla_nvme_abort_work() warn: variable dereferenced before check 'fcport' (see line 183)

# https://github.com/0day-ci/linux/commit/69efeca5ca5e394664f54ef8e349a31b0f424507
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 69efeca5ca5e394664f54ef8e349a31b0f424507
vim +/fcport +245 drivers/scsi/qla2xxx/qla_nvme.c

e84067d7 Duane Grigsby               2017-06-21  230  static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
e84067d7 Duane Grigsby               2017-06-21  231      struct nvme_fc_remote_port *rport, struct nvmefc_ls_req *fd)
e84067d7 Duane Grigsby               2017-06-21  232  {
9dd9686b Darren Trapp                2018-03-20  233  	struct qla_nvme_rport *qla_rport = rport->private;
9dd9686b Darren Trapp                2018-03-20  234  	fc_port_t *fcport = qla_rport->fcport;
e84067d7 Duane Grigsby               2017-06-21  235  	struct srb_iocb   *nvme;
e84067d7 Duane Grigsby               2017-06-21  236  	struct nvme_private *priv = fd->private;
e84067d7 Duane Grigsby               2017-06-21  237  	struct scsi_qla_host *vha;
e84067d7 Duane Grigsby               2017-06-21  238  	int     rval = QLA_FUNCTION_FAILED;
e84067d7 Duane Grigsby               2017-06-21  239  	struct qla_hw_data *ha;
e84067d7 Duane Grigsby               2017-06-21  240  	srb_t           *sp;
e84067d7 Duane Grigsby               2017-06-21  241  
e84067d7 Duane Grigsby               2017-06-21 @242  	vha = fcport->vha;
                                                              ^^^^^^^^^^^
Dereference.

e84067d7 Duane Grigsby               2017-06-21  243  	ha = vha->hw;
69efeca5 Quinn Tran                  2019-06-18  244  
69efeca5 Quinn Tran                  2019-06-18 @245  	if (!ha->flags.fw_started || (fcport && fcport->deleted))
                                                                                      ^^^^^^
Check for NULL is too late.

69efeca5 Quinn Tran                  2019-06-18  246  		return rval;
69efeca5 Quinn Tran                  2019-06-18  247  
e84067d7 Duane Grigsby               2017-06-21  248  	/* Alloc SRB structure */
e84067d7 Duane Grigsby               2017-06-21  249  	sp = qla2x00_get_sp(vha, fcport, GFP_ATOMIC);
e84067d7 Duane Grigsby               2017-06-21  250  	if (!sp)
e84067d7 Duane Grigsby               2017-06-21  251  		return rval;
e84067d7 Duane Grigsby               2017-06-21  252  
e84067d7 Duane Grigsby               2017-06-21  253  	sp->type = SRB_NVME_LS;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
