Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD051F4B22
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2020 04:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgFJCDf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Jun 2020 22:03:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42128 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCDf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jun 2020 22:03:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05A22hik102911;
        Wed, 10 Jun 2020 02:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=QveDZg30MOOAbZTP12jlsSCSngLlZQHSsESF1vrXEKU=;
 b=bZi5MJgTajpxsPHRTMAy7G/kwN8l95bxhTx6V25CFB14JRSQwxUKgJyDZpE/6HbMTU3O
 wZbzrj/mlp/zOLN3FDYMoJZ/SCuFVhPZrBgdRRfFpOe3UzvEiAsjrc/TNv5FilLD+QGt
 2wyfpNHttbkCzHAvcEypaRNBKmnj7VxTzHg4yd+nFBitPguzirQwqYqyxwe5ch7MgFuP
 eMhpkLbWj8AW3yzbKjqjXi9GLHm03oIBaa0VQuQ3pXgZwIKLhJDpbubrIflZ8dRSBazw
 YrO0edk1qfR+ARMP8vMb9zdk5KP3rB60yWXMGMl6yMP31wt8Y6tHy6SvrLFSSm5Cjymk BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3smyr30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 02:03:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05A1vgRs091385;
        Wed, 10 Jun 2020 02:03:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31gn2xm4t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 02:03:03 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05A22tGq003331;
        Wed, 10 Jun 2020 02:03:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 19:02:54 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Simon Arlott <simon@octiron.net>, Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Merlijn Wajer <merlijn@archive.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] scsi: sr: Fix sr_probe() missing mutex_destroy
Date:   Tue,  9 Jun 2020 22:02:47 -0400
Message-Id: <159175452257.16072.17569880133353520216.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <06e9de38-eeed-1cab-5e08-e889288935b3@0882a8b5-c6c3-11e9-b005-00805fc181fe>
References: <06e9de38-eeed-1cab-5e08-e889288935b3@0882a8b5-c6c3-11e9-b005-00805fc181fe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100013
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 30 May 2020 18:58:25 +0100, Simon Arlott wrote:

> If the device minor cannot be allocated or the cdrom fails to be
> registered then the mutex should be destroyed.

Applied to 5.8/scsi-queue, thanks!

[1/2] scsi: sr: Fix sr_probe() missing mutex_destroy
      https://git.kernel.org/mkp/scsi/c/a247e07f8dad
[2/2] scsi: sr: Fix sr_probe() missing deallocate of device minor
      https://git.kernel.org/mkp/scsi/c/6555781b3fde

-- 
Martin K. Petersen	Oracle Linux Engineering
