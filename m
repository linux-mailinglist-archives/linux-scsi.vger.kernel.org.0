Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1776B770D7
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 20:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfGZSDc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 14:03:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbfGZSDc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 14:03:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QI2Ht5021281
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 14:03:31 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u03wbg9ma-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 14:03:31 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Fri, 26 Jul 2019 19:03:30 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Jul 2019 19:03:26 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6QI3Q6j49152440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 18:03:26 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA0F36E04C;
        Fri, 26 Jul 2019 18:03:25 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A91E6E04E;
        Fri, 26 Jul 2019 18:03:24 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.131.103])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 26 Jul 2019 18:03:24 +0000 (GMT)
Subject: Re: [PATCH 3/4] Complain if scsi_target_block() fails
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Date:   Fri, 26 Jul 2019 11:03:23 -0700
In-Reply-To: <210a31fb-37d1-93ab-c339-f8cc410f65d7@acm.org>
References: <20190726164855.130084-1-bvanassche@acm.org>
         <20190726164855.130084-4-bvanassche@acm.org>
         <1564160404.9950.1.camel@linux.vnet.ibm.com>
         <210a31fb-37d1-93ab-c339-f8cc410f65d7@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072618-0012-0000-0000-00001756A2D2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011498; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01237808; UDB=6.00652513; IPR=6.01019190;
 MB=3.00027905; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-26 18:03:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072618-0013-0000-0000-0000583A455F
Message-Id: <1564164203.9950.5.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260216
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 2019-07-26 at 11:00 -0700, Bart Van Assche wrote:
> On 7/26/19 10:00 AM, James Bottomley wrote:
> > On Fri, 2019-07-26 at 09:48 -0700, Bart Van Assche wrote:
> > > If scsi_target_block() fails that can break the code that calls
> > > this
> > > function. Hence complain loudly if scsi_target_block() fails.
> > > 
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Hannes Reinecke <hare@suse.com>
> > > Cc: Johannes Thumshirn <jthumshirn@suse.de>
> > > Cc: Ming Lei <ming.lei@redhat.com>
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > > ---
> > >   drivers/scsi/scsi_lib.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > > index bbed72eff9c9..c9630bd59b5a 100644
> > > --- a/drivers/scsi/scsi_lib.c
> > > +++ b/drivers/scsi/scsi_lib.c
> > > @@ -2770,6 +2770,8 @@ int scsi_target_block(struct device *dev)
> > >   	else
> > >   		device_for_each_child(dev, &ret, target_block);
> > >   
> > > +	WARN_ONCE(ret, "ret = %d\n", ret);
> > > +
> > 
> > If this is the only point to the previous change to make SCSI
> > target block return an error, why not put the WARN_ONCE in
> > device_block?  That way you'll at least know which device was the
> > problem.
> 
> Hi James,
> 
> Adding a WARN_ON_ONCE() statement in device_block() sounds like a
> good idea to me. But since scsi_target_block() can fail, I think it
> should  have a return value that indicates whether or not it
> succeeded.

I don't disagree, but nothing in this patch set actually uses it ... is
there a plan for something to use the scsi_target_block return value to
perform some action other than issue a warning?   If not, it likely
makes better sense simply to add the warn once to the device block ...
unless there's some problem that might make it too verbose for a target
(say 100 devices each of which would issue the warning).

James

