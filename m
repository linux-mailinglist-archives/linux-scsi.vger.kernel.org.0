Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DA579E8
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 05:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfF0DT5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 23:19:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50764 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF0DT5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 23:19:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R38wRJ186977;
        Thu, 27 Jun 2019 03:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=DMjVWKsfQOCcy3Di2g2wEnB2LgbbRik7AdFryBgm0og=;
 b=mUDoZdrK1E6r5HwdqFscr5sh7/uTC1OCXKIcO3c0omxtDbpLM/Ka8mOzRaAOj19zrALE
 YB7LwCac0BP3HBrML8laggcx9+xLzFvWj7lLVIZlAaReNUvlkT4oVkNPPradEMvJeHRt
 3R/+LVydU3w7LD8tt/k6SZmjrdL9sneBmLgMSYUVw50U0y4sn7mJOz5fERbyNMakK1DV
 pjJy590Oinb+DMPWAdwMYI9XQiZf5Pgpyl6xL9CIIyMeMja/1r2A31yNW8ayyKJDMN2P
 gaLUTtGFFBF9jyN8c+UUNMs8n0hwJj6kbxUMlMkDPTtrEcnzG7mbbqDwwx6aN8FCAR5S HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t9c9pwmwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 03:19:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R3ImO7129622;
        Thu, 27 Jun 2019 03:19:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6v3jj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 03:19:53 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R3Jq1V009290;
        Thu, 27 Jun 2019 03:19:52 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 20:19:52 -0700
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        suganath-prabu.subramani@broadcom.com, sathya.prakash@broadcom.com
Subject: Re: [PATCH 0/4] mpt3sas: bug fix patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
Date:   Wed, 26 Jun 2019 23:19:50 -0400
In-Reply-To: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
        (Sreekanth Reddy's message of "Mon, 24 Jun 2019 10:42:52 -0400")
Message-ID: <yq1y31nk949.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=833 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270035
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Sreekanth,

> This patch set contains some mpt3sas driver's bug fix patches.

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
