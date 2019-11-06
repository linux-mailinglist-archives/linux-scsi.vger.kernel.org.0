Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00A1F0DD2
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Nov 2019 05:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfKFEbl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 Nov 2019 23:31:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53488 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKFEbl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 5 Nov 2019 23:31:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA64Sqli082794;
        Wed, 6 Nov 2019 04:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=/ZtPK4ZzB/bJ4YHeBLzDhoB9Htw2t7HAj0EdVtIAxYs=;
 b=KOzxI+wHrJmkXUlq4JRGQMqUME1PSKA4AB/wK8cxpLpgjR4Dc25QVtcAcp0vtTlQA6c6
 NpAI51zzWsKOH8gz63vCyNMi/1GS5LRPsv8eyOzAQWuyMLrxmyEXa7kUsOl72idfah0f
 tQWciEGUVics40iEKHeSqP1XhHOORDlfF4T5KtMbjiv0xpd+GGwSfUgWQs9VWQP7rdwg
 yOkBM2t/4JG5kBVEnWX4awQIwGOBPHPnD+67gBWou7wrRbaqa5VhLfZvk160vao0qmnw
 VyR4i/7PKP34Va0znPpKIEoIFkbPMXNqrsJyWTo+HchCKjuGmxtILHIdK0hiFh+YKyA7 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w11rq32m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 04:31:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA64Spdu006375;
        Wed, 6 Nov 2019 04:31:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w35pq6xsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 04:31:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA64VFSn001743;
        Wed, 6 Nov 2019 04:31:15 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Nov 2019 20:31:15 -0800
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage\@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: [PATCH v2] scsi: Fix scsi_get/set_resid() interface
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191030090847.25650-1-damien.lemoal@wdc.com>
        <af516590-58dc-0377-5c54-ac63cffbafc8@acm.org>
        <BYAPR04MB5816D4B866F2E7CC421E8488E7600@BYAPR04MB5816.namprd04.prod.outlook.com>
        <a33afd2e-a7d6-5584-dc26-79fb8f3d6a97@acm.org>
        <a640ee15-515b-6811-9883-48b49ead9276@suse.de>
        <BYAPR04MB581685E630A8EA91902B2F9BE77E0@BYAPR04MB5816.namprd04.prod.outlook.com>
        <yq1eeym52a5.fsf@oracle.com>
        <BYAPR04MB58164FF9171FDA66879E7400E77E0@BYAPR04MB5816.namprd04.prod.outlook.com>
Date:   Tue, 05 Nov 2019 23:31:12 -0500
In-Reply-To: <BYAPR04MB58164FF9171FDA66879E7400E77E0@BYAPR04MB5816.namprd04.prod.outlook.com>
        (Damien Le Moal's message of "Tue, 5 Nov 2019 05:24:04 +0000")
Message-ID: <yq1bltp39tb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=513
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=593 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060046
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Damien,

> Or keeping resid_len as an unsigned int and adding a flag specifying
> if the value means underflow or overflow ?

It's been broken for so long I'd rather make the overflow case an
opt-in. So a separate flag, please.

-- 
Martin K. Petersen	Oracle Linux Engineering
