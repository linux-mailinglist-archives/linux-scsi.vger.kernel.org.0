Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0AF0E1FB
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfD2MKL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 08:10:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55902 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfD2MKK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 08:10:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TBxJ6u174552;
        Mon, 29 Apr 2019 12:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=eO+WeBwXThwVYjqeDJnmfub6mk8vfWpvsgLsFE27TUA=;
 b=3vDupI+YvWhPWCQRqr2DW8GywhVi8w6S1GSM4PlU0lpIFr3MtPQkRCUruYTU7tQcIoHc
 xktWfXA3cA6tjslCy2LLccm9n9Hv3+HZ/x0S7u84ppdR/iV60baCmd3gKRmZ9grss4Oi
 uA5orsLnuXVm9hZUP7axrP89gZtS6paIpyGSPTaXF/HmDFKn6f25uOYE3CG7/3CXUZAV
 ya5PVqZW6W8Np18lNgkijKnTt3c5oMRj6Z+wvijpfLL44Ss+kR0j2QktPp5DfkrwULO4
 rAdwWhw271jdP9Uc6V8Xf8iQ0ZreYGkl/Zo3ZLw6PFL7NlZCl9D2LNwW/UnEnuGByjm7 Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s5j5ttkp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:10:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TC8nmg149552;
        Mon, 29 Apr 2019 12:10:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2s4d49wguc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:10:00 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3TC9wv5011654;
        Mon, 29 Apr 2019 12:09:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 05:09:58 -0700
To:     Manish Rangankar <mrangankar@marvell.com>
Cc:     <martin.petersen@oracle.com>, <lduncan@suse.com>,
        <cleech@redhat.com>, <linux-scsi@vger.kernel.org>,
        <QLogic-Storage-Upstream@cavium.com>
Subject: Re: [PATCH v2 0/2] Ramrod timer and ep state fixes.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190426105546.11850-1-mrangankar@marvell.com>
Date:   Mon, 29 Apr 2019 08:09:56 -0400
In-Reply-To: <20190426105546.11850-1-mrangankar@marvell.com> (Manish
        Rangankar's message of "Fri, 26 Apr 2019 03:55:44 -0700")
Message-ID: <yq1ef5l108b.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=907
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290088
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=935 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290088
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Manish,

> Please apply the following patches to the scsi tree at your earliest
> convenience.

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
