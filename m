Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D2A7B432
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jul 2019 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfG3UQ0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 16:16:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58244 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfG3UQ0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 16:16:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UKEYZE100090;
        Tue, 30 Jul 2019 20:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=UfbHE3qcXcy9A2Pl8jfx5kx3amM2LiKO5Yj3PFd0jlU=;
 b=sbnVxXMGM3Oh5hAmqp46qG+i5ajaiHuzShyTcN4LOpmFNN2vDRDcalOwB2hi448P3NAd
 KWoToAfd/GTwHzU/aIuP4j3s9xPFdGSGgwLzlrOniIoYApR3ZooQgfP3hyOT+EkJZYiE
 kCZCKqBuv84gftUoRS0Sg4hmRENJa24ykHHnn+wTRkjkEowFm14fKGlqpicqcD0lCq0f
 1oAaomcHZ9sJ62VFRgbER4szWLP+3Uktygmc+ts83s8P/jQcPtYX4mEE69uM52jXi02y
 9BO3xr8xVuExpU7LlMJ2yVU9leUfBTfTRujc+TJawWCDYGptfpbhMQU/4CK447CjcS/U Jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u0ejpgspt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 20:16:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UKD0Wa078599;
        Tue, 30 Jul 2019 20:16:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u2exake0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 20:16:21 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6UKGK5j014460;
        Tue, 30 Jul 2019 20:16:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 13:16:20 -0700
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 00/15] qla2xxx: Bug fixes for the driver
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190726160740.25687-1-hmadhani@marvell.com>
Date:   Tue, 30 Jul 2019 16:16:18 -0400
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com> (Himanshu Madhani's
        message of "Fri, 26 Jul 2019 09:07:25 -0700")
Message-ID: <yq1k1bzl1m5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=689
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300206
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=757 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300206
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Himanshu,

> This series contains bug fixes for the driver. Most of the fixes are
> obvious memory leak and/or error handling fixes.
>
> Please apply this series to 5.4/scsi-queue at your earliest
> convenience.

Applied to 5.4/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
