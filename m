Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAC76B4A0
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jul 2019 04:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfGQCgn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jul 2019 22:36:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53454 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQCgm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Jul 2019 22:36:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H2Y8Qo087484;
        Wed, 17 Jul 2019 02:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=z0ur2cOvecK/x6uygCGUpqF4QBKeWLcmlP9rQC4z4iI=;
 b=Ox5eVHm+FpUgC5QVG3k5/TBUER49hTNEqYHrG+18Mgj0nyxO+xnGMdNWj8eCpxiY8QL7
 GGlgteZY3JHPGGt2fZ4ucIA6aNtEemZaM6p66YU5HFLhmnWD+PnP7WyhHGIYUPTl+a+f
 puWYj3gZIq8Li7GMNXaERQ7bNG6klB5dTHSKG3eEm/g/FJ0NoHd20TXQNJo+AqI8KMFm
 GlSCdr4t6gb/ldUaRmuJy6rlWcKrDmixWUgyvaib9v0c4vLYFddNvSadViOOtRE8mTPE
 aF/UNndk6fFbog80gsfmBxsuh6b/QpAmo2tcjguSnG7EiJLpE6CglJzhUwdkLwMP6XHp AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xqyqsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 02:36:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H2XM4h078375;
        Wed, 17 Jul 2019 02:36:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tsmcc50ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 02:36:27 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H2aPgU006254;
        Wed, 17 Jul 2019 02:36:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 02:36:24 +0000
To:     Zhang Guanghui <zhang.guanghui@h3c.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] scsi_dh_alua: always use a 2 seconds delay before retrying RTPG
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190712065347.93517-1-hare@suse.de>
Date:   Tue, 16 Jul 2019 22:36:21 -0400
In-Reply-To: <20190712065347.93517-1-hare@suse.de> (Hannes Reinecke's message
        of "Fri, 12 Jul 2019 08:53:47 +0200")
Message-ID: <yq1k1chz8t6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=719
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=786 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170030
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Zhang,

> Retrying immediately after we've received a 'transitioning' sense
> code is pretty much pointless, we should always use a delay before
> retrying.

Does Hannes' patch alleviate your issue?

-- 
Martin K. Petersen	Oracle Linux Engineering
