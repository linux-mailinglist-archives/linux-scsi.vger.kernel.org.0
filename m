Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7F50B32
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 14:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfFXM4M (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 08:56:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfFXM4M (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 08:56:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCsH8T142990;
        Mon, 24 Jun 2019 12:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=qBtE7sGwA87+xuHMqYneEv1QZDMB/76C0feGN55wyx0=;
 b=uWG74qSOevMqS3+3gY+xVCFUKT/S2CjrcyT8GpbVO7o4lS51CYzqQe3TPv2Q9/jDqh7M
 T1VtuMC79SxAgwvQgBGyCRV3E8PfZqxbAstE1fZC1zD5fV+LphmQqhwEvo7Ux5R4hUwD
 z337eR1PywfoYftfamjxIBKxI/yiOflJbDrqQ+6ZJdTSVZNp8G5E04g76HrdfzYF+yqy
 v6yszWVTJ+6ifeKFtNnOIIDT/NA9DGsQUw0Y6x3TKIUYI+e5+GbPzIwmDhvxj5pWezMq
 znoIjDt3Zo55K2FRiOSU73wk1J+RfB8rUw7YeoLwQQ+RKHKjLnaZZyyapt67QT2t75p+ jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t9cyq666q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:54:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCrn9W105054;
        Mon, 24 Jun 2019 12:54:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t99f38p0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:54:49 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5OCsiOw018764;
        Mon, 24 Jun 2019 12:54:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 05:54:43 -0700
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list\:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH V5 00/16] use sg helper to operate scatterlist
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190618013757.22401-1-ming.lei@redhat.com>
        <yq11rzqzacx.fsf@oracle.com>
        <3df71d64-78fb-c6fc-f456-a0b626abff3b@acm.org>
        <yq1wohhs62v.fsf@oracle.com>
        <CACVXFVM2ZiSwqy9QpE2A2VDWY5-dny-H=Lw2J0bEh7zuA5aj5Q@mail.gmail.com>
Date:   Mon, 24 Jun 2019 08:54:39 -0400
In-Reply-To: <CACVXFVM2ZiSwqy9QpE2A2VDWY5-dny-H=Lw2J0bEh7zuA5aj5Q@mail.gmail.com>
        (Ming Lei's message of "Mon, 24 Jun 2019 20:40:15 +0800")
Message-ID: <yq1pnn3nnxs.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=726 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240105
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Ming,

> Today I found the whole patchset disappears from 5.3/scsi-queue, seems
> something is wrong?

Your changes are in 5.3/scsi-sg. I put them in a separate branch to
avoid having to rebase the rest of the queue in case we find more
issues.

My for-next branch is based on 5.3/scsi-queue and 5.3/scsi-sg.

-- 
Martin K. Petersen	Oracle Linux Engineering
