Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2682624EE
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 04:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIICMH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 22:12:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43080 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgIICMF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 22:12:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892ASjS094079;
        Wed, 9 Sep 2020 02:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LeM08fKThdl5/aX6JHwsFEnFuxQm9szMFtNERqQX6Iw=;
 b=xEyBx647j2Dh7f00ZvBcy2PUPdaZjV+eMUBB/1IEUau/y/yAAdZf9X+yOJgZvdl/5ubA
 ab1BZvFa/gzWhAFWrZ1673rHt+2wiNnHwG/Q7KiuncmU2HgXxnVmz2WP55YIsyKct9yA
 ziGQDG4riDWFgzQGpULorrErKUFggK/NgcOTQAYK3bqlYUIQZR0ARpEECJIEGjGmrjav
 2jXrasSx84m+ZtyXZxrJo76RGVivZKWMnYVtTRYbGA+jJq1PRM1nRo8nWxJZ5mxEzn49
 Xeo4LKV/N2JAooX2/1qX6JD//BF2EfOyglKrT2GqJ1qhraNXjKONVQlKItTu6PNLpPiW IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mkxvth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:11:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892522T095313;
        Wed, 9 Sep 2020 02:09:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33cmk53f2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:09:44 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08929hTN007023;
        Wed, 9 Sep 2020 02:09:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:09:43 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     aacraid@microsemi.com, hare@suse.de,
        Jason Yan <yanaijie@huawei.com>, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] scsi: dpt_i2o: remove set but not used 'pHba'
Date:   Tue,  8 Sep 2020 22:09:21 -0400
Message-Id: <159961731706.5787.582180402400049720.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827125812.427753-1-yanaijie@huawei.com>
References: <20200827125812.427753-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090018
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 27 Aug 2020 20:58:12 +0800, Jason Yan wrote:

> This addresses the following gcc warning with "make W=1":
> 
> drivers/scsi/dpt_i2o.c: In function ‘adpt_slave_configure’:
> drivers/scsi/dpt_i2o.c:411:12: warning: variable ‘pHba’ set but not used
> [-Wunused-but-set-variable]
>   411 |  adpt_hba* pHba;
>       |            ^~~~

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: dpt_i2o: Remove set but not used 'pHba'
      https://git.kernel.org/mkp/scsi/c/e34ce005a177

-- 
Martin K. Petersen	Oracle Linux Engineering
