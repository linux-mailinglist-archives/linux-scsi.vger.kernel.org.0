Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217A627DF02
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 05:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgI3DfC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Sep 2020 23:35:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41902 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgI3DfB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 29 Sep 2020 23:35:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U3NwKK178171;
        Wed, 30 Sep 2020 03:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0s9DPxq9WNkXg/S4URXBUJpyzJOLxk0th48yVckNwjg=;
 b=eHWtNZx9HamhG2G50d/2KORCzx6KQSz+f1T6kAhhUoLVDJJnUoDcfUj0VrL0+bd/sF6G
 MrG6wqO5HnVtRlaTh5CCnuHOrV9MTQv1+1Uhn0A8eiI3LLC0aUTjZbafNzr6mVJhlW0f
 3DejusXzQGM61mSer+2zg+BsHJehSsHmLF79do+tUHGBXz4ldBdk+iD2wCCsZbKnL0Y3
 5fnzUKS0rBhoFuVaNk2HlZdm4WnygUnX/Bh323N01KKIMjHo+Vm/XY36hxvxJqzLVMJS
 kwfGAc/VhP8gKU7EPbN7hKmoYcHZ2BiM8irLGL8hD1BFDutxDFOKj85UGnj/u4jaXzXm 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33swkkx9pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 03:34:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U3PuRX024598;
        Wed, 30 Sep 2020 03:34:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33tfjxwcmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 03:34:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08U3Yqha027453;
        Wed, 30 Sep 2020 03:34:52 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 20:34:52 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, Brian King <brking@linux.vnet.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        tyreld@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ibmvfc: Protect vhost->task_set increment by the host lock
Date:   Tue, 29 Sep 2020 23:34:45 -0400
Message-Id: <160143685412.27701.17223336650096895762.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1600286999-22059-1-git-send-email-brking@linux.vnet.ibm.com>
References: <1600286999-22059-1-git-send-email-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300023
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 16 Sep 2020 15:09:59 -0500, Brian King wrote:

> In the discovery thread, ibmvfc does a vhost->task_set++ without
> any lock held. This could result in two targets getting the same
> cancel key, which could have strange effects in error recovery.
> The actual probability of this occurring should be extremely
> small, since this should all be done in a single threaded loop
> from the discovery thread, but let's fix it up anyway to be safe.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: ibmvfc: Protect vhost->task_set increment by the host lock
      https://git.kernel.org/mkp/scsi/c/2584e5aef87a

-- 
Martin K. Petersen	Oracle Linux Engineering
