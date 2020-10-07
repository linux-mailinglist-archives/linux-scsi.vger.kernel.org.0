Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A873285756
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Oct 2020 05:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgJGDui (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Oct 2020 23:50:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39958 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgJGDui (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Oct 2020 23:50:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0973mVcm169269;
        Wed, 7 Oct 2020 03:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qJen2LN3dGmVKOMJ4XdaJGBMYeHq3nmUQkRkwTXR26k=;
 b=p+15ztrENS+sV7xk8wr2msGICruXXwIgAH60Yxlve3x8QOw+Bnio0HzEJFr78d2TexNe
 EFWmre7hlZDqZA0yILS7eleC9kI1Hi7POddjZAK3YFlYQuwFsmAF15nXtiIIvFa5zn00
 iCJCMChZDQSgznu8WHBLgGvGTbwwoUkq3tPGnRTx84w89ymErms3hVePgYaVEdjGlRnR
 6+LuOeWSpGyXXreY3Cz/K3+oGv4qFiUi/JoJtZHX8dMeRZV3A8cWsgs8WamdoyRtDQw+
 aoj86L/dgVcW9Fie/XxFpdlhZdVU+6Sqq3qG0wPmx8irVZ4Srn88zYYqpaoN2NvngUpn qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33xhxmydh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 03:50:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0973iq00194761;
        Wed, 7 Oct 2020 03:48:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3410jy2s7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 03:48:28 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0973mSkI002167;
        Wed, 7 Oct 2020 03:48:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 20:48:27 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        linux-scsi@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] scsi: lpfc: Remove Unneeded variable 'status' in lpfc_fcp_cpu_map_store
Date:   Tue,  6 Oct 2020 23:48:05 -0400
Message-Id: <160204240581.16940.17987560004222170971.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916022859.349089-1-yebin10@huawei.com>
References: <20200916022859.349089-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070023
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 16 Sep 2020 10:28:59 +0800, Ye Bin wrote:

> Fixes coccicheck warning:
> drivers/scsi/lpfc/lpfc_attr.c:5341:5-11: Unneeded variable: "status". Return "- EINVAL" on line 5342

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: lpfc: Remove unneeded variable 'status' in lpfc_fcp_cpu_map_store()
      https://git.kernel.org/mkp/scsi/c/37fa429ef7ba

-- 
Martin K. Petersen	Oracle Linux Engineering
