Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F44E1BF85
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 00:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEMWfu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 May 2019 18:35:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48516 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMWfu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 May 2019 18:35:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DMYDCO020276;
        Mon, 13 May 2019 22:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=w/lJv4+zQGbCtmnDcTaYbrFIL6cfK7vPGwt3QuLby88=;
 b=iP9rMLe6og3CzGWRUXlvM+G7rFEGhFcbxVqW7hxjkpJ5EuCrlmwH2tSGWdGSOLQdiywX
 p3khfKqr2UMEVETu65XoTW63AuJmMa3RQ1UwWXGOkXIZrcVq7tqbCq0mUoUEk9Ap1jGv
 ZjBMfM7uCF+zhzvzWub/HcN5N7YVYxM0JjaZpTN0ymDRswI0G7IoHjesRm9ojGnkWa1D
 GmGaZbLP4z4+7JS2pWF2HAFaGQiYWJbyu42aeONSOJC7WcnHk6hY/qvEMfDZtnX2H+I3
 Z/iT+TnpcurJ8WXtgk+Dcd9aEAG0PlJrq+aSGqE2UTKDUoN3h9JZpZl+8E8N9xYNJuCz lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2sdkwdjbaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 22:35:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DMZOAE040731;
        Mon, 13 May 2019 22:35:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2sdmearb3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 22:35:45 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4DMZgZl006638;
        Mon, 13 May 2019 22:35:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 May 2019 15:35:42 -0700
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2/2] qla2xxx: Add cleanup for PCI EEH recovery
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190506205219.7842-1-hmadhani@marvell.com>
        <20190506205219.7842-3-hmadhani@marvell.com>
Date:   Mon, 13 May 2019 18:35:40 -0400
In-Reply-To: <20190506205219.7842-3-hmadhani@marvell.com> (Himanshu Madhani's
        message of "Mon, 6 May 2019 13:52:19 -0700")
Message-ID: <yq14l5ygeyr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=748
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905130150
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=796 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130151
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Himanshu,

> During EEH error recovery testing, it was discovered that driver's
> reset() callback partially frees resources used by driver, leaving
> some stale memory.  After reset() is done and when resume() callback
> in driver uses old data which results into error leaving adapter
> disabled due to PCIe error.

Applied to 5.2/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
