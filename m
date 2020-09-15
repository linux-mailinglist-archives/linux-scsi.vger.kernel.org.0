Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519A926B04B
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 00:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgIOWHF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 18:07:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgIOWG7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Sep 2020 18:06:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FM4liv007862;
        Tue, 15 Sep 2020 22:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=bME8sByLBwNLbJudnSNj1nVjUvDsDQdQqcKom0FlSRU=;
 b=UddL6Nf2SGObJgM1ltSAQP4mmCOnhSztzmrrycS6VZb59UaxuT3GDEb9yWOFagzKYvEK
 +k47QxtHY6JKMnF9VKHHUruMzfpT83dYu4p3/B7V4SNFe0Hq+CfV4lm331WRKEe/XMuQ
 XL7ihvNT9i2A3TyoPPGsqhV58ONZLjpOR3MNH+voqTPZjLakdCZhamCQIrcsNtxP3+qa
 94o6ySUp3QBIpk8B7nvZR4r51bboSHU+YoaqVlXLqIc7FB6aF7Xw07TUFwewlx29rGbR
 H7cxtHg8HPNNFh30MKeZrj9ScZ66a64gMOV31cebAT/LLgVAmwkc9wEQhiKeXOxIA76E Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33j91dhenn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 22:06:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FM1okB041321;
        Tue, 15 Sep 2020 22:06:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33hm31brbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 22:06:35 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FM6WIK026369;
        Tue, 15 Sep 2020 22:06:32 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 22:06:31 +0000
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     <martin.petersen@oracle.com>, <bvanassche@acm.org>,
        <michael.christie@oracle.com>, <mlombard@redhat.com>,
        <sudhakar.panneerselvam@oracle.com>, <ddiss@suse.de>,
        <gustavoars@kernel.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: target: remove redundant assignment to variable
 'ret'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1een24rvk.fsf@ca-mkp.ca.oracle.com>
References: <20200914023207.113792-1-jingxiangfeng@huawei.com>
Date:   Tue, 15 Sep 2020 18:06:28 -0400
In-Reply-To: <20200914023207.113792-1-jingxiangfeng@huawei.com> (Jing
        Xiangfeng's message of "Mon, 14 Sep 2020 10:32:07 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=1 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150171
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Jing,

> The variable ret has been initialized with a value '0'. The assignment
> in switch-case is redundant. So remove it.

Applied to 5.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
