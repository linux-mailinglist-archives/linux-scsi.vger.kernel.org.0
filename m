Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CBBE1026
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Oct 2019 04:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbfJWCmY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Oct 2019 22:42:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48536 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfJWCmY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Oct 2019 22:42:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N2dxPS040561;
        Wed, 23 Oct 2019 02:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=BOMIM0qJpKftkmTp2/DXxh1Jk4ZVQovuQbzQ6r5LR5U=;
 b=VFpIpDW4qp6A0v86GGAvvWiZNfClqJSOBpISGYw3OMFfduEIJ1kn1hyhhU78O332QcDB
 npmSmVnzBEDB31fLD9c6EXiE+SnHEnC6+bGlfwoyOpTcVR1NLaeM0MQMtDT0KwBNsNZ4
 34AWo4Yc0Uqeennqsyu0gQqPZX+0YqHx6thF4EsVA4P29mIocxITat3rJ1NiMFEIV4wC
 Qse6ApiWTILQEV+bMU+/151MLegpe3rtMeQCC0rniri/B3ZVvZAo6Ho5zm9hY/kVjph1
 S9ZMpI2NuSgKON+L3oncQDlAUvo9jFlM7x70D1HdgSb7JoKyi5Y5l7JsIzV9Hq9QqnmE pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vqteptc1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 02:42:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N2d6k1012843;
        Wed, 23 Oct 2019 02:40:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vt2heaen8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 02:40:14 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9N2eC17031533;
        Wed, 23 Oct 2019 02:40:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 19:40:12 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <manoj@linux.ibm.com>, <mrochs@linux.ibm.com>,
        <ukrishn@linux.ibm.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: cxlflash: remove set but not used variable 'ioarcb'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191021141957.18828-1-yuehaibing@huawei.com>
Date:   Tue, 22 Oct 2019 22:40:09 -0400
In-Reply-To: <20191021141957.18828-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Mon, 21 Oct 2019 22:19:57 +0800")
Message-ID: <yq11rv4dw1i.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=825
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=924 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230025
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


YueHaibing,

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/scsi/cxlflash/main.c:47:22: warning:
>  variable ioarcb set but not used [-Wunused-but-set-variable]

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
