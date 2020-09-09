Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664E72624D1
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 04:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIICJh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 22:09:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39576 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIICJb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 22:09:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089202aD146665;
        Wed, 9 Sep 2020 02:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=L9NnxLi9mM08gtsRR+AKx4bJMddZ4J78XnLny+Ac8n4=;
 b=jEI1bcnCWsKFwYhmQHO6LE7Kyy65pG5SNCExwc7Vrjlndgt7fufdu8NSBT0n3i2hai1a
 ofq8I0bny7//hYFVcmkpoJRYW/o/e/IVS1Awhh56gqaVhlYx8qusZ5DzW00TlvDGPzWu
 ar6FWnXE9NBqhItqmv6cPOsiGFlgAJlakMhhhilo/sRMJVKQF/v5UgdT53A2ZsMNEKqG
 fLZ64vgJEr4wnXm7MRNuEha+wrckcNtvm2jV/oEth/GyKH/ld+I6ew1m/IlnYETtBzOQ
 JE7bQi6rE3v2TOfZ+13CAGlR4nBJvG6BadtkJdwEDkHBn/Fje6xNa7MzE29pl1WlfYw2 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33c3amxtr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:09:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089252xB095303;
        Wed, 9 Sep 2020 02:09:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33cmk53e9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:09:26 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08929Pqa006888;
        Wed, 9 Sep 2020 02:09:25 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:09:24 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     kernel-team@android.com, ziqichen@codeaurora.org,
        asutoshd@codeaurora.org, hongwus@codeaurora.org,
        Can Guo <cang@codeaurora.org>, rnayak@codeaurora.org,
        salyzyn@google.com, saravanak@google.com,
        linux-scsi@vger.kernel.org, nguyenb@codeaurora.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 0/2] Add UFS LINERESET handling
Date:   Tue,  8 Sep 2020 22:09:07 -0400
Message-Id: <159961731708.5787.8825955850640714260.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1599099873-32579-1-git-send-email-cang@codeaurora.org>
References: <1599099873-32579-1-git-send-email-cang@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=730 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=737 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090017
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2 Sep 2020 19:24:30 -0700, Can Guo wrote:

> PA Layer issues a LINERESET to the PHY at the recovery step in the Power
> Mode change operation. If it happens during auto or mannual hibern8 enter,
> even if hibern8 enter succeeds, UFS power mode shall be set to PWM-G1 mode
> and kept in that mode after exit from hibern8, leading to bad performance.
> Handle the LINERESET in the eh_work by restoring power mode to HS mode
> after all pending reqs and tasks are cleared from doorbell.
> 
> [...]

Applied to 5.10/scsi-queue, thanks!

[1/2] scsi: ufs: Abort tasks before clearing them from doorbell
      https://git.kernel.org/mkp/scsi/c/307348f6ab14
[2/2] scsi: ufs: Handle LINERESET indication in err handler
      https://git.kernel.org/mkp/scsi/c/2355b66ed20c

-- 
Martin K. Petersen	Oracle Linux Engineering
