Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61C42EA64
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 03:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfE3Bxt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 21:53:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32972 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3Bxt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 21:53:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1rlFN172653;
        Thu, 30 May 2019 01:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=XDvw3rdxEbyc9VtOPoi+bOkfcbjL6Trq83hGrPeMlxo=;
 b=y8ADP8kn8abtCDTbesNfL16thKEvwVeVmyKHbT7wK5YlbU8+GY7p3lei8FCfGTQyspFC
 TtRA5nDPrbF45/oEV7xNo90pf7QijUULgjEisQiOP1PBDYSJQAlDmUR3ej+qaAdokpJL
 9oae8LbI9d7VnL/epE1p8CMVreseiMXDyPEL8lHzTqNfxrzAKUZSBE/1h7jzykIVpD8S
 8q9tH7lttV+F2vT/WwARU3PCxt+xhQ3sQR6T7ecxRT4rLIMq/AtORE5dKHLv/jMFM5mt
 Vq4BaZspo9Em6G6PCuaFkH1ll4qKnLLA06alfMxWxK2HpzRs/NoCd/uNZvDqblwbqxOW Ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2spw4tna70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:53:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1qSli177987;
        Thu, 30 May 2019 01:53:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sqh741rvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:53:42 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4U1reOl025712;
        Thu, 30 May 2019 01:53:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 18:53:39 -0700
To:     Steffen Maier <maier@linux.ibm.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 0/2] zfcp fixes for v5.2-rcX
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1558617826-30129-1-git-send-email-maier@linux.ibm.com>
Date:   Wed, 29 May 2019 21:53:37 -0400
In-Reply-To: <1558617826-30129-1-git-send-email-maier@linux.ibm.com> (Steffen
        Maier's message of "Thu, 23 May 2019 15:23:44 +0200")
Message-ID: <yq1d0k0zp0e.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=657
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=710 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300013
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Steffen,

> here are 2 zfcp bugfixes for v5.2-rcX.

Applied to 5.2/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
