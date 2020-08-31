Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A0A257FD2
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Aug 2020 19:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgHaRlo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Aug 2020 13:41:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49196 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgHaRll (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 31 Aug 2020 13:41:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VHT6IL073119;
        Mon, 31 Aug 2020 17:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=SMn6eHs1kXR8URhjyOoVkaBdFlPLxB221ehmdgR3IC0=;
 b=LBuZm2lyD4EyQm/nnO5lGpdQarHurw2JlHw6n++sE6pOuSL7HqI7HGs55x01svHRawdW
 t07YTY0ILpqAzO3whD4znxJDIfRKrckmsmWFaenesVA1szdDQ4jSWUmcDS515kaTMXC6
 mr75rF6Jb9IEyhicFhaCSfN+cPBYFFuptZ91NeSfwK5x/JXwq2hso6O5EbfnRSEEeT2Y
 iwCsfkj1dnYUw//xXfYedZXYiJRX6+suE6+9sq6LpYNmloJOppMgItl6R9JDkrD2LMK9
 Gs6OkKz8U8wIdUD5layXmzEOnHMOsLPhp2j19T8oVkLWZIjEOgZtIFdT5wiUdhA+5m7i lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eeqqmh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 17:41:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VHeuPO029446;
        Mon, 31 Aug 2020 17:41:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3380sqbrwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 17:41:27 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07VHfQb7012472;
        Mon, 31 Aug 2020 17:41:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 10:41:26 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, himanshu.madhani@cavium.com,
        njavali@marvell.com, quinn.tran@cavium.com,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        tianjia.zhang@alibaba.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Remove redundant variable initialization
Date:   Mon, 31 Aug 2020 13:41:12 -0400
Message-Id: <159889566024.22322.2167859336254862000.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200802111527.4928-1-tianjia.zhang@linux.alibaba.com>
References: <20200802111527.4928-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310104
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, 2 Aug 2020 19:15:27 +0800, Tianjia Zhang wrote:

> The initialization value of `rc` is wrong. It is unnecessary to
> initialize `rc` variables, so remove its initialization operation.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: qla2xxx: Remove redundant variable initialization
      https://git.kernel.org/mkp/scsi/c/8905cbdae986

-- 
Martin K. Petersen	Oracle Linux Engineering
