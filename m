Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D865716B
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2019 21:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfFZTRX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 15:17:23 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33102 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbfFZTRX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 Jun 2019 15:17:23 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QJF3W2008504;
        Wed, 26 Jun 2019 12:17:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0818; bh=S19og8Gkgci2tYEULZPTS8hcgDuA5UNujz5RGJeAXP4=;
 b=xrapoUnrPB4VRIqJ96oERvx8/y0xsMBjNpemN5hbFisWoFrSQ8gWUSDxQ12EMUbAUeI6
 JOJzAFAf1vwcNh6gpCu2yorrYkdcQlPP4/3qqxTGVdeZEWvaJcTSq7y0XSQTWqZ0ewyb
 mxcp6dpVe7pnE676vDVOrELIxpP/d++lf1tEcQVLpYlLHAqKDXztICWDnCBBYcpp9aLw
 A3uJt2jWMcs1bZgND73rgsG++TtBNe6Lmb1vWLDtcGlXYNltjfWXJk6DxYXTZ3ZoURfl
 W3iQihRx66kpAyV4+dUwKQqFodC7Eb9CEMbMLPEsn7VxfVi0Mc/l1R2sYocN8Ad3lUS8 jQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tcbgc8vgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 12:17:17 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 26 Jun
 2019 12:17:15 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 26 Jun 2019 12:17:15 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id A35433F703F;
        Wed, 26 Jun 2019 12:17:15 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id x5QJHAZh021967;
        Wed, 26 Jun 2019 12:17:12 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Wed, 26 Jun 2019 12:17:10 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@mvluser05.qlc.com
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <kbuild@01.org>, Himanshu Madhani <hmadhani@marvell.com>,
        <kbuild-all@01.org>, <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] qla2xxx: on session delete return nvme cmd
In-Reply-To: <20190626062022.GB18776@kadam>
Message-ID: <alpine.LRH.2.21.9999.1906261216070.7630@mvluser05.qlc.com>
References: <20190626062022.GB18776@kadam>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_10:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Thanks Dan for reporting the issue.

This is already fixed in v3 of the patch:
	https://marc.info/?l=linux-scsi&m=156113583805280&w=2

Regards,
-Arun

On Tue, 25 Jun 2019, 11:20pm, Dan Carpenter wrote:

> Hi Himanshu,
> 
> url:    https://github.com/0day-ci/linux/commits/Himanshu-Madhani/qla2xxx-Fix-crashes-with-FC-NVMe-devices/20190619-074559
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/scsi/qla2xxx/qla_nvme.c:245 qla_nvme_ls_req() warn: variable dereferenced before check 'fcport' (see line 242)
> drivers/scsi/qla2xxx/qla_nvme.c:496 qla_nvme_post_cmd() warn: variable dereferenced before check 'fcport' (see line 494)
> drivers/scsi/qla2xxx/qla_nvme.c:510 qla_nvme_post_cmd() error: we previously assumed 'qpair' could be null (see line 496)
> 
> Old smatch warnings:
> drivers/scsi/qla2xxx/qla_nvme.c:190 qla_nvme_abort_work() warn: variable dereferenced before check 'fcport' (see line 183)
> 
> # https://github.com/0day-ci/linux/commit/69efeca5ca5e394664f54ef8e349a31b0f424507
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 69efeca5ca5e394664f54ef8e349a31b0f424507
> vim +/fcport +245 drivers/scsi/qla2xxx/qla_nvme.c
> 
> e84067d7 Duane Grigsby               2017-06-21  230  static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
> e84067d7 Duane Grigsby               2017-06-21  231      struct nvme_fc_remote_port *rport, struct nvmefc_ls_req *fd)
> e84067d7 Duane Grigsby               2017-06-21  232  {
> 9dd9686b Darren Trapp                2018-03-20  233  	struct qla_nvme_rport *qla_rport = rport->private;
> 9dd9686b Darren Trapp                2018-03-20  234  	fc_port_t *fcport = qla_rport->fcport;
> e84067d7 Duane Grigsby               2017-06-21  235  	struct srb_iocb   *nvme;
> e84067d7 Duane Grigsby               2017-06-21  236  	struct nvme_private *priv = fd->private;
> e84067d7 Duane Grigsby               2017-06-21  237  	struct scsi_qla_host *vha;
> e84067d7 Duane Grigsby               2017-06-21  238  	int     rval = QLA_FUNCTION_FAILED;
> e84067d7 Duane Grigsby               2017-06-21  239  	struct qla_hw_data *ha;
> e84067d7 Duane Grigsby               2017-06-21  240  	srb_t           *sp;
> e84067d7 Duane Grigsby               2017-06-21  241  
> e84067d7 Duane Grigsby               2017-06-21 @242  	vha = fcport->vha;
>                                                               ^^^^^^^^^^^
> Dereference.
> 
> e84067d7 Duane Grigsby               2017-06-21  243  	ha = vha->hw;
> 69efeca5 Quinn Tran                  2019-06-18  244  
> 69efeca5 Quinn Tran                  2019-06-18 @245  	if (!ha->flags.fw_started || (fcport && fcport->deleted))
>                                                                                       ^^^^^^
> Check for NULL is too late.
> 
> 69efeca5 Quinn Tran                  2019-06-18  246  		return rval;
> 69efeca5 Quinn Tran                  2019-06-18  247  
> e84067d7 Duane Grigsby               2017-06-21  248  	/* Alloc SRB structure */
> e84067d7 Duane Grigsby               2017-06-21  249  	sp = qla2x00_get_sp(vha, fcport, GFP_ATOMIC);
> e84067d7 Duane Grigsby               2017-06-21  250  	if (!sp)
> e84067d7 Duane Grigsby               2017-06-21  251  		return rval;
> e84067d7 Duane Grigsby               2017-06-21  252  
> e84067d7 Duane Grigsby               2017-06-21  253  	sp->type = SRB_NVME_LS;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
