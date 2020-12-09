Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781982D47E0
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Dec 2020 18:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbgLIR0E (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Dec 2020 12:26:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54700 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbgLIRYx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Dec 2020 12:24:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9HNvrB082525;
        Wed, 9 Dec 2020 17:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eWw1906LMcZmpONRexg+uXyr7dy4BMG+q8mlH0cG9NY=;
 b=wQsomDEdfzZ8DIcUpwrGkzDNBZlShoeE/31QA/rLuCMG9W80s8EDUwjg6fb86PFoz4W9
 LOcobuhcucvbO7GaXSWYjr1NSOeqsLcNlpZ1cwwiLeuqx5lfRWcDTaxGLXQwL0STUW70
 tqa+SLzzEQD1NDgXvLVFj1AEMDlX9kfNnUnp3Iz8U8zxqrcOemD9rdKUJwuWIscU1wU3
 D3TWiHqNvi4yD0pWbDu+GJY61g5yhgT/k5NeE9nMUkBvsZ5xapeIa5rXp30RQH55RexL
 M8qFMzK6tFsGG0WfP0QR1FvsqjL+Wr4V+AnY+YjkCbyzeoRC8qCahxLY6FI55PbeVamz Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3581mr1a6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 17:24:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9HKjhQ142238;
        Wed, 9 Dec 2020 17:24:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 358kyv0ham-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 17:24:07 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B9HO6mg023168;
        Wed, 9 Dec 2020 17:24:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 09:24:06 -0800
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "trix@redhat.com" <trix@redhat.com>, njavali@marvell.com,
        jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: qla2xxx: remove trailing semicolon in macro definition
Date:   Wed,  9 Dec 2020 12:23:25 -0500
Message-Id: <160753457756.14816.5350521450816476863.b4-ty@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130205509.3447316-1-trix@redhat.com>
References: <20201130205509.3447316-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090123
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 30 Nov 2020 12:55:09 -0800, trix@redhat.com wrote:

> The macro use will already have a semicolon.
> Remove unneeded escaped newline.

Applied to 5.11/scsi-queue, thanks!

[1/1] scsi: qla2xxx: remove trailing semicolon in macro definition
      https://git.kernel.org/mkp/scsi/c/8f525bc2a7b2

-- 
Martin K. Petersen	Oracle Linux Engineering
