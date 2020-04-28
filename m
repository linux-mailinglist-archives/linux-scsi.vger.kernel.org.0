Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256291BB38B
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Apr 2020 03:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgD1Bqn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 Apr 2020 21:46:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgD1Bqn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 27 Apr 2020 21:46:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03S1hAwI131674;
        Tue, 28 Apr 2020 01:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=dJB06PwiNDwyIVmz23CpoY3Kf0/QPmn2RTcuMeMk6UA=;
 b=zjy2uAKBVmIxgJ5jSjpRemppecLFPPYoq14IeuBtBtS7Dbr+Tu1lzjAIDMfCmaNi5AKq
 yeQ2Pn3q7tfQkfagtlfcA8f/vFGbjhYA9yqSRSkIW+1o/r1b/c4RgUw35xzOa59jxNwU
 ugIQy33zzvLAFdOJvQ03CCNbG2D7syw0ifwTV20cM2MAb9V7iYy5i8lDlZcYAAbr+fa1
 y0l/P/YLwXyf2dx4XrQpc9JfesQSKNv4Qn2x5m7I7+D/QpLXaLfpltkMjz6eebKKIJwD
 JXv7IMqKP0kat3bMGOCqAebGpfCN9Yr2wSH9N34pv9WX7ZAr8H3rTEb8icuvabHhZES/ eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30p01nkgbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 01:46:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03S1gboI018192;
        Tue, 28 Apr 2020 01:46:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30mxpek8n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 01:46:25 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03S1kK87030413;
        Tue, 28 Apr 2020 01:46:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 18:46:20 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     james.bottomley@hansenpartnership.com,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        brking@linux.ibm.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ibmvscsi: fix WARN_ON during event pool release
Date:   Mon, 27 Apr 2020 21:46:19 -0400
Message-Id: <158803829798.31703.6497962066918806539.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <1588027793-17952-1-git-send-email-tyreld@linux.ibm.com>
References: <1588027793-17952-1-git-send-email-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=948 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1011
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280011
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 27 Apr 2020 15:49:53 -0700, Tyrel Datwyler wrote:

> While removing an ibmvscsi client adapter a WARN_ON like the following
> is seen in the kernel log:

Applied to 5.7/scsi-fixes, thanks!

[1/1] scsi: ibmvscsi: fix WARN_ON during event pool release
      https://git.kernel.org/mkp/scsi/c/cff6a5746645

-- 
Martin K. Petersen	Oracle Linux Engineering
