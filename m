Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7668E291
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Aug 2019 04:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfHOCIz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Aug 2019 22:08:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49154 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfHOCIy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Aug 2019 22:08:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F24JhT095629;
        Thu, 15 Aug 2019 02:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=jfOJE/OTVqh57A82byRhyR16QaRQKw/LiqGpwxAm4O4=;
 b=lTUo7x9uqLMMKawWyMuR4kQRnp//0lTJZdLsJiOVMH0uzpjHwxK0UXhhGb0F7GF/t/5M
 XgngwFf58RVCEuUsBSYgV7FBIxoqt1YudegWvxvl0aRBVcVKhgwFuSlI3V4PzR6OvtTt
 8MoZI4g9p29WO5/fjAuej9/Z6xOwqJZqpUSvHlAzGESDnqExq/guKbI7g1KaDlc/MRZk
 pfKSZ54BEUrWjlMhDOleR0kpi4enZ3DJ8bBOIhnsBCcC5ixFs9CLGwKYhHiLptM+igL6
 OMwnw+xF2i4DT82yQYfgwz0P3e+gQob8TvbAEJzLi2dWf+o8hczkX05g5N8WPS5qqEsC ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u9pjqr3qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 02:08:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F28c53074371;
        Thu, 15 Aug 2019 02:08:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ucs87fysr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 02:08:44 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7F28gkJ003988;
        Thu, 15 Aug 2019 02:08:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 19:08:41 -0700
To:     Martin Wilck <Martin.Wilck@suse.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Joe Carnuccio <joe.carnuccio@cavium.com>,
        Quinn Tran <qutran@marvell.com>,
        Hannes Reinecke <hare@suse.de>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] scsi: qla2xxx: fixes for FW trace/dump buffers
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190814132642.5298-1-martin.wilck@suse.com>
Date:   Wed, 14 Aug 2019 22:08:39 -0400
In-Reply-To: <20190814132642.5298-1-martin.wilck@suse.com> (Martin Wilck's
        message of "Wed, 14 Aug 2019 13:28:25 +0000")
Message-ID: <yq18srv2na0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=668
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=725 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150021
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Martin,

> The first patch of the series is a fix for a memory corruption we
> saw in a test where qla2xxx was loaded/unloaded repeatedly under
> memory pressure. The second one is a cleanup/consistency fix.

Applied to 5.4/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
