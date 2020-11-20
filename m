Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C61C2BA139
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Nov 2020 04:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgKTDeK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 22:34:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36580 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgKTDeK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 Nov 2020 22:34:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AK3SXsm098115;
        Fri, 20 Nov 2020 03:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gpHNhwltXbctafKIWWGNMwxN2Xhap722syu01cunpG4=;
 b=lkO5viPCzEiYVU0WjjD0kPJw8rndx/fbx95SrjBrohBdkXP3Z/wiO6KpSnLZUuSrqfke
 L+oH3aomQXSl+jM23FL5sGe6JTOz5xN5nvxs/uDxPDK4b71sp70wDxP+Kdy7tV9TXW1B
 ZzI+UobTAtwvSmQ77151SS47TPCRkWQc4gGLnB31UhEoEsM7X/HgXZ4PuTrdGVv9dHxJ
 pguDN+aNRuqv8uf3CLMpLt609t6qSdko55JECJRz7diZb7aJcs8CzLuiafpt/vMz8F1B
 0fAU7vHlGpHY7np3+dghWESHNO4a4xuYIRgqW35iS7UHcX94eh1C4HB8oUYJWnaAMxn3 SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34t76m8r30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 03:33:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AK3PP59032478;
        Fri, 20 Nov 2020 03:31:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34umd2w0wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 03:31:58 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AK3Vvx6029968;
        Fri, 20 Nov 2020 03:31:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 19:31:57 -0800
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, Zou Wei <zou_wei@huawei.com>,
        subbu.seetharaman@broadcom.com, ketan.mukadam@broadcom.com,
        jitendra.bhivare@broadcom.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH -next] scsi: be2iscsi: Mark beiscsi_attrs with static keyword
Date:   Thu, 19 Nov 2020 22:31:46 -0500
Message-Id: <160584262852.7157.3690097884416896355.b4-ty@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1605339474-22329-1-git-send-email-zou_wei@huawei.com>
References: <1605339474-22329-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200023
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 14 Nov 2020 15:37:54 +0800, Zou Wei wrote:

> Fix the following sparse warning:
> 
> ./be_main.c:167:25: warning: symbol 'beiscsi_attrs' was not declared. Should it be static?

Applied to 5.11/scsi-queue, thanks!

[1/1] scsi: be2iscsi: Mark beiscsi_attrs with static keyword
      https://git.kernel.org/mkp/scsi/c/4ab2990a5ce1

-- 
Martin K. Petersen	Oracle Linux Engineering
