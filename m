Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2211735522
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 04:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfFECOL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 22:14:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50106 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFECOK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 22:14:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x552DpVl036365;
        Wed, 5 Jun 2019 02:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=vGYATL7lKerrKTUV1eWjFKUy4cU2Egt2DpNjUAywJhM=;
 b=QwBBcWdP74ksA8zuUHuA1MuDeYbxUm8bsHvsyQj8wdYmWRIP31h22KysOCYs4n+xGLi/
 CCA8LovIh3M282IQQO1ctKKVJNYbVHDDx3KECIwBzMUJHnhDiDMDsCOLrZxTmIz40Zz6
 uGUA9zJfEnLaeC4Wrnzgsd+Fy6nWV9VGSUT/bHbnQyikHhEYPVwuNo2XpDVJ/XEurYTT
 KBAQyTY9E7+dBuQ4VjMeQ/4o2fMk+sld1pFLTlRQGOuRMgIW/6Bn7gFqtbAdw8/xD3dL
 ynW83VgyT1MdhS5iPSW/f2ikVu3oOcxs1/S4snzaMEDGB+8g5jY97+XgBNPxMPjFL1Wm SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2suj0qg7gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 02:13:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x552AwW9035898;
        Wed, 5 Jun 2019 02:11:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2swngknt4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 02:11:59 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x552Bv6e013090;
        Wed, 5 Jun 2019 02:11:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 19:11:57 -0700
To:     Avri Altman <avri.altman@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Subject: Re: [PATCH] scsi: ufs: Check that space was properly alloced in copy_query_response
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1558427062-5084-1-git-send-email-avri.altman@wdc.com>
Date:   Tue, 04 Jun 2019 22:11:54 -0400
In-Reply-To: <1558427062-5084-1-git-send-email-avri.altman@wdc.com> (Avri
        Altman's message of "Tue, 21 May 2019 11:24:22 +0300")
Message-ID: <yq14l54srv9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050012
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Avri,

> struct ufs_dev_cmd is the main container that supports device management
> commands. In the case of a read descriptor request, we assume that the
> proper space was allocated in dev_cmd to hold the returning descriptor.
>
> This is no longer true, as there are flows that doesn't use dev_cmd
> for device management requests, and was wrong in the first place.

Applied to 5.2/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
