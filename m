Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F728D69E
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Oct 2020 00:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgJMWoT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Oct 2020 18:44:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46878 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgJMWnY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Oct 2020 18:43:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DMYaru143702;
        Tue, 13 Oct 2020 22:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ETFMLL4floVAa7+3SEeIq0mUzCy/Ub0glnpnODdKOdE=;
 b=Z7cwf/bwZB8aX4XhZdfFWj5P9YZIYkmSvyQDCtoJRw5SMGbWAerQwWOKvpXoYd94c2Zj
 feg3Rb5+jVxP8FM+KStxacKCnMhnZYyvF8JF0xHJzk3UEUCMT64O5Uy9tG54ouJymfcy
 jR+Dak7tEf9OKXd3VycZoWHHy/r4U18pr/qDCDUndZoiZvEC8xa3O6rMBEStMGogPt5j
 HtTVm5hxdlsqhk6CSdDD4881bV8Eo+Tm8MAyg/8aY8MdljYGb3fAPAgrLF8yp7g4P4s3
 dFFwNQvPL9G8POVxBNM+K9od4EBB23ApxxpSn+0KVqDxdAbUhBzbKYI29yllZSxP42gd nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 343pajucr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 22:43:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DMZeMX129686;
        Tue, 13 Oct 2020 22:43:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 343phntsvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 22:43:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09DMhErj002561;
        Tue, 13 Oct 2020 22:43:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 15:43:13 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, hare@kernel.org,
        Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: myrb: remove redundant assignment to variable timeout
Date:   Tue, 13 Oct 2020 18:42:51 -0400
Message-Id: <160262862434.3018.4059156329742181760.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929022458.40652-1-jingxiangfeng@huawei.com>
References: <20200929022458.40652-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130158
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 29 Sep 2020 10:24:58 +0800, Jing Xiangfeng wrote:

> The variable timeout has been initialized with a value '0'. The assignment
> before while loop is redundant. So remove it.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: myrb: Remove redundant assignment to variable timeout
      https://git.kernel.org/mkp/scsi/c/5f6dcb55a7fa

-- 
Martin K. Petersen	Oracle Linux Engineering
