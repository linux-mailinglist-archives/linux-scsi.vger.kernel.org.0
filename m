Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1D28D685
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Oct 2020 00:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgJMWni (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Oct 2020 18:43:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34490 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbgJMWnf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Oct 2020 18:43:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DMYH0i023277;
        Tue, 13 Oct 2020 22:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qe0c5UeHMZVQmZmnfLeg6qeWXmS48HIMqp8EXQpfe5g=;
 b=KbI/XMMwVbkmcfMFuAkAxYZfSzFZH31wskCfJEVz2P8B9vU1ud33P3iLcQjAw/rcJzus
 1to1ka56zFuHN/SFJ3UU/FofRNL2ZOvUYoZYYZ6zytmmAAy7SwdYA8JAcPaW1mKEsclG
 Bg53J+dnL8NPq20ZNC6TTeR+K3WH/+gY5HUBodnPIH2BwTBVPjGWw3/3RCsIrnwbxDBc
 Mj1L21n+aDhLT2A7M0Qql/qbtHGfYwdUs7KNaYyH4HvPIvCu27V++LzB5hUlzyZLSByy
 xGYTZnK5uU4aS87+Y8tCRXsskbl/vm2gtnXaUfh3UMXJvWxCEzbUe1R/e86/x8hg8oz9 BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3434wkmr8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 22:43:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DMZWCN162404;
        Tue, 13 Oct 2020 22:43:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 344by2v0hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 22:43:29 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09DMhSnQ014613;
        Tue, 13 Oct 2020 22:43:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 15:43:28 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Ye Bin <yebin10@huawei.com>, njavali@marvell.com,
        linux-scsi@vger.kernel.org, mrangankar@marvell.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] scsi: qla4xxx: Fix Fix inconsistent of format with argument type in ql4_nx.c
Date:   Tue, 13 Oct 2020 18:43:04 -0400
Message-Id: <160262862434.3018.4679043818167237846.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930022228.2840587-1-yebin10@huawei.com>
References: <20200930022228.2840587-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130158
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 30 Sep 2020 10:22:28 +0800, Ye Bin wrote:

> Fix follow warning:
> [drivers/scsi/qla4xxx/ql4_nx.c:3228]: (warning) %ld in format string (no. 1)
> 	requires 'long' but the argument type is 'unsigned long'.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: qla4xxx: Fix inconsistent format argument type
      https://git.kernel.org/mkp/scsi/c/5ccdd101351d

-- 
Martin K. Petersen	Oracle Linux Engineering
