Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403EC258594
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Sep 2020 04:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgIACZA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Aug 2020 22:25:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57576 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIACZA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 31 Aug 2020 22:25:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0812Nwe7035549;
        Tue, 1 Sep 2020 02:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=P/kwFPVy7ioHMKQLpyv5e14sMLl0RkgNPDJ90iIm7Dg=;
 b=NcaqY8coziQVvNKkzAt2haaAybmkU8fq6T5lgQhhZyf1miwzNsrxeQ6NjWhpXvlBYHGp
 kz+nB/1icz08nCY+8rJUPyNwMJTQezQlv5o8uGqZ/D/WRsc1L1FwXxYXvp17uylqh4mW
 oIOvpy2LZDjust1AdatPCD1qRseTOnTpqafavKvzC2QxY+FW7s4pc2NGhARON57M2rVx
 Eg+ShAM3slqV+XhHZZLqFGlvKnZ/STQ9VXXmKNoXnVbxTnDMp9wN9zOEi6p56DDesWXY
 CdEVW8xF5BfQ34dIRjaixxGntAA9TjKotkWongXnvHtZSmtmZBJHIqHQoMsecIsla54U DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 337qrhghvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 02:24:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0812OvBK158903;
        Tue, 1 Sep 2020 02:24:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3380sqvw37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 02:24:57 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0812OstY024996;
        Tue, 1 Sep 2020 02:24:54 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 19:24:54 -0700
To:     Javed Hasan <jhasan@marvell.com>
Cc:     <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [PATCH 0/8] qedf: Misc fixes for the driver.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1d036gs4h.fsf@ca-mkp.ca.oracle.com>
References: <20200825064354.16361-1-jhasan@marvell.com>
Date:   Mon, 31 Aug 2020 22:24:52 -0400
In-Reply-To: <20200825064354.16361-1-jhasan@marvell.com> (Javed Hasan's
        message of "Mon, 24 Aug 2020 23:43:46 -0700")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=1 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010020
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hi Javed,

> This series has misc bug fixes and code enhancements.
>
> Kindly apply this series to scsi-queue at your earliest convenience.

Please see Documentation/process/submitting-patches.rst about how to
write commit descriptions.

 - Please use imperative mood.

 - Please describe why the change is necessary.

 - Please refrain from writing commit descriptions as lists ("-Changed
   the debug parameter permission from read to read & write.").

 - Please skip the "." at the end of each patch title.

Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
