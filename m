Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43716127402
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Dec 2019 04:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLTDgu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Dec 2019 22:36:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37072 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTDgt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 Dec 2019 22:36:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK3YKMJ041760;
        Fri, 20 Dec 2019 03:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=MstUpraTKjCqubLsp4zo++M0TSOS+HtXc3K1A+3svjM=;
 b=nJrNYYUuQU36r/xik2nG5eI3ssWiReQptEQ933qPGKIvxiCDOeMCoRoyD4gYRnBc1w4L
 VXu8/ugD/9Q1ctAHx1Pl3iGGt1nfIODlNBMqaMbD5tsm3nOIxsvG0fgMMdq7KODDA5xc
 Te40O8sID0Oo0LQgteW/1hw/aXRI3MpUk7DEzRcQ2UqpKstwQMR35Y/nFmibmjh9ZJFV
 CEYz/4DxvnO598rLqDH+DqGlFK90hDEg1BhHew6IXeH8TTGOeTq8uOdNwwCDP8lA1SHq
 /VdiRRnXIx/jlr0M3V6g/M/khfR9YeQ/74B8smWHxKloCdZFcv1ltNEYDuBqllgMDPgQ Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2x01knpe01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 03:36:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK3YHMi145298;
        Fri, 20 Dec 2019 03:36:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2x0bgmuvkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 03:36:46 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBK3akbE024297;
        Fri, 20 Dec 2019 03:36:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 19:36:45 -0800
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH 00/10] lpfc: Update lpfc to revision 12.6.0.3
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191218235808.31922-1-jsmart2021@gmail.com>
Date:   Thu, 19 Dec 2019 22:36:44 -0500
In-Reply-To: <20191218235808.31922-1-jsmart2021@gmail.com> (James Smart's
        message of "Wed, 18 Dec 2019 15:57:58 -0800")
Message-ID: <yq1woar8y7n.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=876
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200024
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


James,

> Update lpfc to revision 12.6.0.3

Applied to 5.6/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
