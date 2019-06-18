Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4A44A6DE
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 18:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfFRQ23 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 12:28:29 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50764 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729295AbfFRQ23 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Jun 2019 12:28:29 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IGA9Ls009760;
        Tue, 18 Jun 2019 09:28:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0818; bh=3wNGAkz2Y4FXa+G3FHp0yjPECwCK7oCkwqxeRcK3PRw=;
 b=p0WErjS81ldcO8+4z4tpkqPRPxLSxiYtZhb2aXW4irIAzHhFu8DyOhkuAa5e4z+plsK0
 B/3Tvx5wtjClrJxfHGOmlwqJaxolBFQ0wOFMOx+y9W/iOSc6ZReFd9+YgpEg9yyhUNce
 lKyC9gCKHOVljYuysAIE+C9/2blN46GgbjLxsfGpPUHOoGbbDf60ik18yHJAjBEINeZy
 AfO8e8GGDOqtsTTE+bObG5wAEl9WLYdyLeeCnHm6fbFRnJ5JRS9gaZo6tidfzb3Leoos
 mYK1ip92pJXOwbDphu3QNl+pwiEiSJAFoxpMjXLQ71SpOtg9/+2nIj6TRIBXeKTovnyU yA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t6xkh18tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 09:28:16 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 18 Jun
 2019 09:28:14 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 18 Jun 2019 09:28:14 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id 2DC453F7041;
        Tue, 18 Jun 2019 09:28:14 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id x5IGS97o014340;
        Tue, 18 Jun 2019 09:28:10 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Tue, 18 Jun 2019 09:28:09 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@mvluser05.qlc.com
To:     Hannes Reinecke <hare@suse.de>
CC:     Himanshu Madhani <hmadhani@marvell.com>,
        <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/3] qla2xxx: Fix kernel crash after disconnecting NVMe
 devices
In-Reply-To: <271857f5-e4c0-4e1c-2555-57aebcc6dd3e@suse.de>
Message-ID: <alpine.LRH.2.21.9999.1906180919320.18638@mvluser05.qlc.com>
References: <20190614221020.19173-1-hmadhani@marvell.com>
 <20190614221020.19173-2-hmadhani@marvell.com>
 <271857f5-e4c0-4e1c-2555-57aebcc6dd3e@suse.de>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_07:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 18 Jun 2019, 3:51am, Hannes Reinecke wrote:

> On 6/15/19 12:10 AM, Himanshu Madhani wrote:
> > From: Arun Easi <aeasi@marvell.com>
> > 
> > BUG: unable to handle kernel NULL pointer dereference at           (null)
> > IP: [<ffffffffc050d10c>] qla_nvme_unregister_remote_port+0x6c/0xf0 [qla2xxx]
> > PGD 800000084cf41067 PUD 84d288067 PMD 0
> > Oops: 0000 [#1] SMP
> > Call Trace:
> >  [<ffffffff98abcfdf>] process_one_work+0x17f/0x440
> >  [<ffffffff98abdca6>] worker_thread+0x126/0x3c0
> >  [<ffffffff98abdb80>] ? manage_workers.isra.26+0x2a0/0x2a0
> >  [<ffffffff98ac4f81>] kthread+0xd1/0xe0
> >  [<ffffffff98ac4eb0>] ? insert_kthread_work+0x40/0x40
> >  [<ffffffff9918ad37>] ret_from_fork_nospec_begin+0x21/0x21
> >  [<ffffffff98ac4eb0>] ? insert_kthread_work+0x40/0x40
> > RIP  [<ffffffffc050d10c>] qla_nvme_unregister_remote_port+0x6c/0xf0 [qla2xxx]
> > 
> > The crash is due to a bad entry in the nvme_rport_list. This list is not
> > protected, and when a remoteport_delete callback is called, driver
> > traverses the list and crashes.
> > 
> > Actually, the list could be removed and driver could traverse the main
> > fcport list instead. Fix does exactly that.
> > 
> > Signed-off-by: Arun Easi <aeasi@marvell.com>
> > Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
> > ---
> >  drivers/scsi/qla2xxx/qla_def.h  |  1 -
> >  drivers/scsi/qla2xxx/qla_nvme.c | 52 ++++++++++++++++++++---------------------
> >  drivers/scsi/qla2xxx/qla_nvme.h |  1 -
> >  drivers/scsi/qla2xxx/qla_os.c   |  1 -
> >  4 files changed, 25 insertions(+), 30 deletions(-)
> > 
> [ .. ]
> > diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
> > index d3b8a6440113..2d088add7011 100644
> > --- a/drivers/scsi/qla2xxx/qla_nvme.h
> > +++ b/drivers/scsi/qla2xxx/qla_nvme.h
> > @@ -37,7 +37,6 @@ struct nvme_private {
> >  };
> >  
> >  struct qla_nvme_rport {
> > -	struct list_head list;
> >  	struct fc_port *fcport;
> >  };
> >  
> Where is the point of this structure now?
> Please drop it, and use fc_port directly.
> 

It could be removed, but was kept to add fields in the future if needed. 
Not much of a strong preference, so one more nudge and I will remove it. 
v2 was planned to be posted soon, so please let me know if you would like 
this to be changed.

-- arun
