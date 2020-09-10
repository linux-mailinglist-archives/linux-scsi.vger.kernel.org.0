Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883A9264947
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Sep 2020 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgIJQDu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Sep 2020 12:03:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60950 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731482AbgIJQCz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Sep 2020 12:02:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AEBOw9176964;
        Thu, 10 Sep 2020 14:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Bcx2l8Sn/99nygVABlzYumMb7K+pjCccmBpzgHjZ8kg=;
 b=l3BcWT9F1jmRKSgR7XZEG30tjzFq6xKj8+GJ4BcPLIfHoEx0JAPIeRnd34rDT64vBPpS
 Re2/mpJTZ/TzHik+AMXGwZQ7/8vvXqCykytY80B89QpkaLIDengJrMRz4QYGBvD7Jz/Q
 mZTNN+v0iVbMDCmByScL19xe05+UyW2miIKprcimRYf8dUQlOzVGQPtScmT5FoJVsJgw
 ppEnNbgAyCjM7vlWBIrNV7TVz03KucV+0tiv30JZPAfVwqyBsQDbEZVUQU14cTXluqso
 JxzEtCgxTCai/EIDJwQHkYFWfv6UkX1anC+yFWLK0MZzXoEJFV6luPUSXPJJnd5J4zEU cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mm8a30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 14:11:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AEB8aj023310;
        Thu, 10 Sep 2020 14:11:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33cmk9utcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 14:11:33 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08AEBVnn003540;
        Thu, 10 Sep 2020 14:11:31 GMT
Received: from dhcp-10-154-107-125.vpn.oracle.com (/10.154.107.125)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Sep 2020 07:11:31 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH 0/3] Improve error handling
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200910073952.212130-1-damien.lemoal@wdc.com>
Date:   Thu, 10 Sep 2020 09:11:30 -0500
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Content-Transfer-Encoding: 7bit
Message-Id: <4FC25ED6-8B7A-4D96-B8C3-F7808F170B65@oracle.com>
References: <20200910073952.212130-1-damien.lemoal@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=695 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=705
 malwarescore=0 suspectscore=3 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100131
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



> On Sep 10, 2020, at 2:39 AM, Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> 
> A small series to improve command error hadling.
> 
> The first patch is a simple code cleanup. The second patch updates
> asc/ascq sense codes list. Finally, the third patch adds zone resource
> errors handling for zoned block deives to return BLK_STS_DEV_RESOURCE,
> similarly to what the NVMe driver does for ZNS devices.
> 
> Damien Le Moal (3):
>  scsi: Cleanup scsi_noretry_cmd()
>  scsi: update additional sense codes list
>  scsi: handle zone resources errors
> 
> drivers/scsi/scsi_error.c  |  4 +--
> drivers/scsi/scsi_lib.c    | 12 +++++++++
> drivers/scsi/sense_codes.h | 54 +++++++++++++++++++++++++++++++++++++-
> 3 files changed, 67 insertions(+), 3 deletions(-)
> 
> -- 
> 2.26.2
> 

For the Series with updated Patch 3. 

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

