Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7738A5B
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 14:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfFGMba (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 08:31:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43354 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfFGMb3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 08:31:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57COo5X133314;
        Fri, 7 Jun 2019 12:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=grgdrhRTkYLamOfX8ff8k2OEjDX0NLOzO5UwZ93viis=;
 b=uElMYGR4fMBLxVoEwabx0mdryCXM42v2kz4ZMk+1AI7cIA8tvLwFVWuFxbbf9sCMNk1g
 3c3nyVdmb0H1dltrIUnJbsgSd852zvNUTKhNABpy4KMrBBzwAMfPVv2Rx7fNc6wjSyiB
 SvOwVy33HO2C4pYMm8vQzaQq79U+g/aBOViayd0PPn0vVNMeDsFqPY7K4di/xft1dgLH
 tiYeMtTmzs1SUBp2rg7l75JQIdN40Yv7NIgjokej2CRKxziqqJjYsOMxeJ9il5FAyzMG
 +6lmsJb2V5yzDyG4So7bMQXEsOmLZY6peDPrhMfy3Kpx7EBPfWUQpJnQ4Kw05TW0QrRg DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2suevdx889-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 12:31:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57CUhRX079458;
        Fri, 7 Jun 2019 12:31:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2swnhd7yu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 12:31:05 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x57CV10n029325;
        Fri, 7 Jun 2019 12:31:01 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 05:31:01 -0700
To:     Hannes Reinecke <hare@suse.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 1/3] scsi: Do not allow user space to change the SCSI device state into SDEV_BLOCK
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190605201435.233701-1-bvanassche@acm.org>
        <20190605201435.233701-2-bvanassche@acm.org>
        <cec3e805-c834-a389-9666-bb79ed86057d@suse.de>
        <22ce1f30-a3c5-fc7d-0f1e-e2ca589682bb@acm.org>
        <470d4c41-1f9e-730e-a1dc-a27f9e971bc1@suse.com>
Date:   Fri, 07 Jun 2019 08:30:58 -0400
In-Reply-To: <470d4c41-1f9e-730e-a1dc-a27f9e971bc1@suse.com> (Hannes
        Reinecke's message of "Fri, 7 Jun 2019 07:52:17 +0200")
Message-ID: <yq1tvd1lgql.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=793
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=843 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070089
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hannes,

> So let's restrict userspace to only ever setting 'RUNNING' or
> 'OFFLINE'.  None of the other states make sense to set from userspace.

Yes, please!

-- 
Martin K. Petersen	Oracle Linux Engineering
