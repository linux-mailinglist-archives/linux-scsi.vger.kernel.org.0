Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB962D47E5
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Dec 2020 18:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbgLIR1J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Dec 2020 12:27:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35080 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbgLIR1E (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Dec 2020 12:27:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9HPOWg116856;
        Wed, 9 Dec 2020 17:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CRW9AtLAh8tamm5b9BCkJhbAH/VTBnS52ibbt6AVf38=;
 b=C8K/GS2u8VienUkz2gG649yQYdDbAFpxhhoF89c+aE4UA8od+X4LgsbxhRJwes7tYx0X
 Vr1qXEJIBh5ESArU4sC4aMqh/eTk4pgQcdeirLnedf6ugSaOqhYEwRBmObFbgweYqWpI
 jrqh2r1tCUkPGI1b9rhi5MnXLnwATwZFLVY81lIw0iNU5JV0dp0TX/Gr1pLH0umv6Q1m
 +BlSvNhS+qZan8R+f+lFyrqMpwKyVV+AJYYrnr0avV9qFDpD8lF3TOBxDXTGL8EuNKDV
 XgO6gZxw7p4nTM/UjC3+rWQWrP/cbnrAZqkS3zuULHM2mkIS8dk511spFElAOdbV39wX 1g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35825m9d6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 17:26:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9HKiQJ142075;
        Wed, 9 Dec 2020 17:24:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 358kyv0hbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 17:24:09 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9HO7u6014463;
        Wed, 9 Dec 2020 17:24:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 09:24:07 -0800
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Mike Christie <michaelc@cs.wisc.edu>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Satish Kharat <satishkh@cisco.com>,
        Joe Eykholt <jeykholt@cisco.com>,
        Abhijeet Joglekar <abjoglek@cisco.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: fix error return code in fnic_probe()
Date:   Wed,  9 Dec 2020 12:23:26 -0500
Message-Id: <160753457755.14816.621209546530451406.b4-ty@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1607068060-31203-1-git-send-email-zhangchangzhong@huawei.com>
References: <1607068060-31203-1-git-send-email-zhangchangzhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090123
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 4 Dec 2020 15:47:39 +0800, Zhang Changzhong wrote:

> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Applied to 5.11/scsi-queue, thanks!

[1/1] scsi: fnic: fix error return code in fnic_probe()
      https://git.kernel.org/mkp/scsi/c/d4fc94fe6557

-- 
Martin K. Petersen	Oracle Linux Engineering
