Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5812066373
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 03:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfGLBr1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 21:47:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46092 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfGLBr1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 21:47:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1ivXY138640;
        Fri, 12 Jul 2019 01:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=lUr4pEK97pdBH4V0aq6pPj1v0dNF1EifeHrWBEsDHG4=;
 b=wrTaw/1br9D1dUv5MQuMapcI3TR+X3mUAK6MiNHsM+3x9pp07uCsqJkW5otnWo68kwA+
 5Lf0wbPl9zk6aOzhVkHLppRV87QYo/GBUtrrTbObLAAMiiTqrS8ChJkT/bwBTyqyLSNs
 EXC42WMfSmTkwnSgzVNZJzA3tGzSILaSC0FsJZPlpbv26UmJv+GKLJPfStXNlHmmyeZM
 7TAWRxsFPdraGR9NyTWQKyetPOUdW/uSH3bGZNCcyGF4JQkIeB5G4hYawrZ68IrGo3m2
 Be6I98l/AecvXFkQIkjXW5+33MIdecTcqF/rmZ7I2zES4yU+XxXLV6tq7HVr4J9HwXwD hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tjm9r30ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:47:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1hAOo147988;
        Fri, 12 Jul 2019 01:47:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tmwgyguy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:47:15 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C1lDrW022207;
        Fri, 12 Jul 2019 01:47:15 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 18:47:13 -0700
To:     Hannes Reinecke <hare@suse.de>
Cc:     Zhangguanghui <zhang.guanghui@h3c.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi \(linux-scsi\@vger.kernel.org\)" 
        <linux-scsi@vger.kernel.org>
Subject: Re: scsi_dh_alua: re-initialize pg->interval in alua_rtpg_work
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <E3535A62B291B54FBD1D003696CCB5370109330EA0@H3CMLB14-EX.srv.huawei-3com.com>
        <20190602180033.GR24680@kadam>
        <E3535A62B291B54FBD1D003696CCB537011CED1F5C@H3CMLB12-EX.srv.huawei-3com.com>
Date:   Thu, 11 Jul 2019 21:47:11 -0400
In-Reply-To: <E3535A62B291B54FBD1D003696CCB537011CED1F5C@H3CMLB12-EX.srv.huawei-3com.com>
        (Zhangguanghui's message of "Wed, 26 Jun 2019 02:47:10 +0000")
Message-ID: <yq1lfx458io.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=875
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=927 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120020
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hannes,

Please opine!

> Thank you very much for you reply, I have tried to contact 3PAR about
> this issue.  Hundreds of them flooding the log for some seconds that
> is an serious problem.  It can be reproduced on the Linux 4.14 kernel
> version or the lastest version for 3PAR storage Remote Copy Failover
> platform when the main storage is powered off.  How to solve it ?
>
> I have found that the lastest patch 'pg->interval = 2000' is
> incorrect, pg->interval = 2 maybe is reasonable, 2 seconds delay,
> retry .  But I have an new idea.  I am wondering if the patch is
> reasonable to use the function printk_timed_ratelimit(&j, 500), can
> you help me review and commit this patch, Best regards

-- 
Martin K. Petersen	Oracle Linux Engineering
