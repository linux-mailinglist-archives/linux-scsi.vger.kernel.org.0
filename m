Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F423D5799D
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 04:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfF0CoN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 22:44:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41534 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfF0CoN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 22:44:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R2XUE1051103;
        Thu, 27 Jun 2019 02:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=6hhEHl8cv+r1Mlcjci3pYxBSwCJt2R5sdB/kqyprVZ4=;
 b=zecEX2AoZQjtr7U+MXDLuqUAO67rOKen3UBRrl4iRZuD/lpXN3u52fo6JNAanDonM+nG
 hZCBrpn8EVcGQAeHeBvXa8ZIgmIa7o+VPNRXPRRl38BKptarxWCmUfO8QBD3rUv8lN3j
 APUYbUatBqa/zPCOVNEAqYkx5ZDc7E2DaRhhEmafztiZjTudO1+hqXU/MiVm3fiYGCzH
 T0Lr5/uFtkDNHdb0OCHPs+/VoF6+w0x0+7hxUIPhF3C5XYh6OLVQNWxd7BTnuyMiNaGm
 5mWOlmjAyQT5QZvTg714I7QRnB2921UFBhA7chDsbAYpPLmElxzQ4x/vgElwrd2LyzLt Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brtdm74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 02:44:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R2gmGA069830;
        Thu, 27 Jun 2019 02:44:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2t9p6v397f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 02:44:01 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5R2i1dX028535;
        Thu, 27 Jun 2019 02:44:01 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 19:44:00 -0700
To:     Lin Yi <teroincn@163.com>
Cc:     QLogic-Storage-Upstream@qlogic.com, skashyap@marvell.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix struct bnx2fc_cmd refcount imbalance in several functions
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1561429511.git.teroincn@163.com>
Date:   Wed, 26 Jun 2019 22:43:58 -0400
In-Reply-To: <cover.1561429511.git.teroincn@163.com> (Lin Yi's message of
        "Tue, 25 Jun 2019 10:33:04 +0800")
Message-ID: <yq17e97lpch.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=768
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=834 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270030
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Lin,

> in bnx2fc_send_rec and bnx2fc_send_srr, it calls the separate kref_put
> on err handle path, we can't release refcount before taking it's
> refcount, so avoid calling it inthe err path.

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
