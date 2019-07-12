Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5106636D
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 03:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfGLBpR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 21:45:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47656 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfGLBpR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 21:45:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1iM7P126937;
        Fri, 12 Jul 2019 01:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=l+8YbJ63QTbrGaWoURi+MoCpKsl46aOet+rXODJDp9U=;
 b=LtGcsUJHBCIehdi6Mes9IxzOrHZtCEzSSsOnsLR79PWEX00S98Ga9yprAX7NoDHSmjmF
 xS5o94Dgk7fzyElEnhD6J4Kl2GG0SJXSLIZw4pfJLSZHyjr0gPqr9HonOfjlBjp7Q/2S
 xSkp8sARB6t1owtMXdbMcMaEOFhufRcgRmpB7Ohc6jHIOZaTCfDjnM1e6y7OKjfZjqtE
 BhqaoyMTxaUZCNi93OBbQ8duHn7EeAYkiPGWHgkKG8m3/YVjNKQsigdO+oH5vh3GBDTF
 WqJ6cX4tcDXQZU1EXqj7b44g4CTLHEI29a7k5ip3duDxnOGI+Y4TyvMkr9VdVKXopUMJ sQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tjk2u3326-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:45:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1h91q147934;
        Fri, 12 Jul 2019 01:45:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2tmwgygukc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:45:10 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6C1jAnX011388;
        Fri, 12 Jul 2019 01:45:10 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 18:45:09 -0700
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Cc:     Minwoo Im <minwoo.im@samsung.com>, sathya.prakash@broadcom.com,
        linux-scsi@vger.kernel.org
Subject: Re: [RESEND RFC PATCH] mpt3sas: support target smid for [abort|query] task
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <CGME20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
        <20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
Date:   Thu, 11 Jul 2019 21:45:07 -0400
In-Reply-To: <20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
        (Minwoo Im's message of "Fri, 21 Jun 2019 15:37:08 +0900")
Message-ID: <yq1pnmg58m4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120020
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Sreekanth/Suganath,

> We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MGMT)
> to /dev/mpt3ctl.  If the given task_type is either abort task or query task,
> it may need a field named "Initiator Port Transfer Tag to Manage" in the IU.
>
> Current code does not support to check target IPTT tag from the tm_request.
> This patch introduces to check TaskMID given from the userspace as a target
> tag.  We have a rule of relationship between (struct request *req->tag) and
> smid in mpt3sas_base.c:

Please review. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
