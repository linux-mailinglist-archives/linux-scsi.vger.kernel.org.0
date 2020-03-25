Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B3819331F
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Mar 2020 22:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCYVzP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 Mar 2020 17:55:15 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39306 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727351AbgCYVzP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 25 Mar 2020 17:55:15 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PLp6Ge003282;
        Wed, 25 Mar 2020 14:55:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0818; bh=Xeed3i6CkZ4hZDIy1pJif7Fc0gg2x9aZIIpDCGFrwYA=;
 b=O8MefANg15qo0m7pxJw7RnAUwzFW9aeCwrBN8YHo4S0/ZOwG8JTMfEeEJmupO7OhAzyR
 b8iEXyZloFxZh8ZDwIR+rM3JSa2LtCqKwSwoIJL40tEKkkUcjNfGA98yyFdHoK+8hYJ7
 itHUwPFoY+NM+bXNEbQBoDpE+tTFJ7rp55pERHNi8ftAFuHdYieVEv/cu3uWBkbposwG
 zr1IJEhqUrKyLF0cbQRck09wCOTQK4f7JZp54VA3cCsUZen4xQlaXHms9us8tcIU+DvV
 Zriukt9uUTLPxbQM8v/eGISEoGXUf6WEFewxOe969XPeE8tjlFtT1UgxFcrIdW4W3zNO Vw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 300bpcrykk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 14:55:08 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Mar
 2020 14:55:05 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Mar 2020 14:55:05 -0700
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
        by maili.marvell.com (Postfix) with ESMTP id EFEE33F7041;
        Wed, 25 Mar 2020 14:55:05 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id 02PLt3M7013532;
        Wed, 25 Mar 2020 14:55:03 -0700
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process doing -bs
Date:   Wed, 25 Mar 2020 14:55:03 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To:     Martin Wilck <mwilck@suse.com>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Quinn Tran <qutran@marvell.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        "Hannes Reinecke" <hare@suse.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "Daniel Wagner" <dwagner@suse.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] scsi: qla2xxx: don't shut down firmware before
 closing sessions
In-Reply-To: <1fe3adead7a07ea3e14c2bc45bd87f58cc370720.camel@suse.com>
Message-ID: <alpine.LRH.2.21.9999.2003251445230.12727@irv1user01.caveonetworks.com>
References: <20200205214422.3657-1-mwilck@suse.com>
         <20200205214422.3657-3-mwilck@suse.com>
         <alpine.LRH.2.21.9999.2003241732470.12727@irv1user01.caveonetworks.com>
 <1fe3adead7a07ea3e14c2bc45bd87f58cc370720.camel@suse.com>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_13:2020-03-24,2020-03-25 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 25 Mar 2020, 8:34am, Martin Wilck wrote:

> On Tue, 2020-03-24 at 17:36 -0700, Arun Easi wrote:
> > On Wed, 5 Feb 2020, 1:44pm, mwilck@suse.com wrote:
> > 
> > > From: Martin Wilck <mwilck@suse.com>
> > > 
> > > Since 45235022da99, the firmware is shut down early in the
> > > controller
> > > shutdown process. This causes commands sent to the firmware (such
> > > as LOGO)
> > > to hang forever. Eventually one or more timeouts will be triggered.
> > > Move the stopping of the firmware until after sessions have
> > > terminated.
> > > 
> > > Fixes: 45235022da99 ("scsi: qla2xxx: Fix driver unload by shutting
> > > down chip")
> > > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > > ---
> > >  drivers/scsi/qla2xxx/qla_os.c | 21 ++++++++++-----------
> > >  1 file changed, 10 insertions(+), 11 deletions(-)
> > > 
> > > 
> 
> ...
> 
> > NAK.
> > 
> > The fcport deletion was done after chip reset to minimize interference 
> > and further action on fcports. We should not be sending out logouts 
> > during unload (driver just implicitly logs out). If you experience any 
> > hangs, please let us know.
> 
> What about target mode? AFAIK target ports need to send explicit LOGO.
> 

I do not see a hard requirement cited in spec, correct me if you see 
otherwise. Other initiators should see a RSCN and see this device has 
gone away.

Regards,
-Arun
