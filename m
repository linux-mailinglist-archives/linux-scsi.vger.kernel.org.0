Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9201A9085
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2020 03:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392647AbgDOBhX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Apr 2020 21:37:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60366 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733274AbgDOBhU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Apr 2020 21:37:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03F1XeCr068864;
        Wed, 15 Apr 2020 01:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=wY3S+4VrImgVcp49qlGLcI3CjULgzEKInUNZKsqXSJM=;
 b=fXM+p0FNXh0Z5IAVfqUJVwkmoo2Hm48y1GEl4CYjF3zU3IWpGThqF5BJ2snoVn4s6FQg
 S15R2ba/oSPBnfwfx7KB8EjsFjOuxBq3P+fb6UFfIpRcY+WJ3lE9akFW6yCG8GXlTyUg
 JDWGM4zm6sg95iorFwpCbcaQdpzIjScynIr9BnK2RtCHNtzKcX5mn6hAJEXCp0SOXr9F
 gbBhQ6bRFvP0WoA7c8n8Lm+Kru7fK5ndkfqXdANTd1XWI8KxpAjrL7bBQnMV2HR0r7jA
 0fNdNO7NWrtmukdfoVxl+ut6oZOdVj0DQW5TroRTmhVRUtSV9s37YXe+a39/YV+DVtka mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30dn9t8k9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 01:35:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03F1X9MT036576;
        Wed, 15 Apr 2020 01:33:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30dn8v2507-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 01:33:11 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03F1X737007179;
        Wed, 15 Apr 2020 01:33:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 18:33:06 -0700
To:     Wang Hai <wanghai38@huawei.com>
Cc:     <achim_leubner@adaptec.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: gdth: Make __gdth_execute static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1586276474-34480-1-git-send-email-wanghai38@huawei.com>
Date:   Tue, 14 Apr 2020 21:33:04 -0400
In-Reply-To: <1586276474-34480-1-git-send-email-wanghai38@huawei.com> (Wang
        Hai's message of "Tue, 7 Apr 2020 12:21:14 -0400")
Message-ID: <yq1h7xlr0rz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=831
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=907 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150008
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Wang,

> Fix sparse warning:
>
> drivers/scsi/gdth.c:332:5: warning:
>  symbol '__gdth_execute' was not declared. Should it be static?

Applied to 5.8/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
