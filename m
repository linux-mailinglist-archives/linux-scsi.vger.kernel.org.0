Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1006C6633A
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 03:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfGLBFS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 21:05:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42412 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGLBFR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 21:05:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C14HPH112124;
        Fri, 12 Jul 2019 01:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=vzV86aF3j7x4Rx+cp83GPVm2vEM8IfwQZYJajwK1WPU=;
 b=N/HiMb+2VEcSvac6H1d2RxQETI4PM2Gtr0P7YPOOEiGqlDL77NHYGOSDb9qLSa8lmipa
 0qbt+p/pCqA65y8m6kqvZp0rP8eBGEdSJIP0Tf0ykoklghExZNzYxXK6ivmLa9K4qCML
 8EGEAPyZULa9mmqx8fDEA1ckWkdTOky3BFBcOj5cgzUtCFNuJMWife7Q8Nb2c1BtkNjM
 zLZzxOzynyJ+TSLUKiZZtYBoEKzUzjU/j9RpVpWQ3Jzkt8LAtpobJYBB+3cQxOybJW8D
 1cwIPt3cugMjbcHMq+OVC14UUdEyCQS0htxkPaefRKDPmv1wEx1DMKcXI1VRl9p6BwTp JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tjm9r2w1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:05:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C12xuJ028006;
        Fri, 12 Jul 2019 01:05:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tmwgyg3tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:05:13 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6C15CIn007814;
        Fri, 12 Jul 2019 01:05:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 18:05:11 -0700
To:     Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, chandrakanth.patil@broadcom.com
Subject: Re: [PATCH 0/4] megaraid_sas: driver updates
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1561715441-1428-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Date:   Thu, 11 Jul 2019 21:05:09 -0400
In-Reply-To: <1561715441-1428-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
        (Shivasharan S.'s message of "Fri, 28 Jun 2019 02:50:37 -0700")
Message-ID: <yq1tvbs6p16.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120012
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Shivasharan,

> This series contains four driver update patches.  The first patch
> contains a fix for calculating the target ID sent to firmware. This
> patch was sent earlier as well[1], but got lost in the v2 series due
> to a mail client issue.  Second patch enables newly added
> "msix_load_balance" flag only for Invader and later generation
> controllers.  Third patch adds a module parameter which controls
> logging of async event notifications from firmware.  Fourth patch
> updates the driver version.  Please consider these patches for
> 5.3/scsi-queue.

Applied to 5.3/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
