Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B6728D68A
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Oct 2020 00:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgJMWny (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Oct 2020 18:43:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbgJMWnj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Oct 2020 18:43:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DMZo65072089;
        Tue, 13 Oct 2020 22:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OjL+jBZ6YBx8kz5Y2pFr8ju/mTcOIdouNxI+KuZUx9U=;
 b=DKOip3PGI8keg2z2rf6fdmn1RYL0I/fjvpqK/qv9uzrCw0Wl72E31tojJY3GlqOAqQsD
 c4cdKiLQkduVtaC6tvoCo2QUiAJL/GqsCoM7o1KeC08G4DKWjIz3c5ivV4Am7ZnPuFuY
 Gzn7BTNzydYaC5foK1SeWsnZl451b7fSCftnkjoLuqQEktEvSuzqiBe0HhTey43btopw
 htD+E7/7kjQtspZKhrSor3t82q9g1nJfAg/Nm6RMZZTb0lL7RnglMTeC3GCc3NJNg6JN
 FfuMes83mmk8iNgx0DKxYJQBxrc9hT67PbWYwChQB9PFgWrpsNqTkhTOQMkKd7NXn9sY QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 343vaeb2cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 22:43:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DMaWmx049113;
        Tue, 13 Oct 2020 22:43:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 343pvx1snx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 22:43:16 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09DMhDOd009858;
        Tue, 13 Oct 2020 22:43:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 15:43:12 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     emilne@redhat.com, hare@suse.de,
        Jing Xiangfeng <jingxiangfeng@huawei.com>, jejb@linux.ibm.com,
        anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: bfa: fix error return in bfad_pci_init()
Date:   Tue, 13 Oct 2020 18:42:50 -0400
Message-Id: <160262862434.3018.13396386652779601952.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925062423.161504-1-jingxiangfeng@huawei.com>
References: <20200925062423.161504-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130158
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 25 Sep 2020 14:24:23 +0800, Jing Xiangfeng wrote:

> Fix to return error code -ENODEV from the error handling case instead
> of 0.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: bfa: Fix error return in bfad_pci_init()
      https://git.kernel.org/mkp/scsi/c/f0f6c3a4fcb8

-- 
Martin K. Petersen	Oracle Linux Engineering
