Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8A92180A2
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jul 2020 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgGHHRS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Jul 2020 03:17:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48354 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgGHHRP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 Jul 2020 03:17:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0687Gc2w148209;
        Wed, 8 Jul 2020 07:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=mLdPzD39oSR6PMplntqvZvNFRRfQ6owLsJmJqM6nmqw=;
 b=Qv/05JX7Z/xOPVwdxPX6IpB0QuKRM1m509UQsTiD09D5zJptoUgT/4/gL04sJvA5W2x3
 RQTCLeoZPvWLPWwcXdw0PBNMdfZdpwy/YpgcIoBCQ35maYeZs3sR0eDSTiF8c3ScX+WX
 +XsrZklWAced9QnU6ukDrvFm9q0yjFJeyTocqcP8shVignNZy/WPlqF6k53X/JWcxyvG
 lnr0sahKhAbJtMTTiOpTT1uNBQexuoQH4o7VjzsW+GmTkIPv5aM8hsaJ9it2tCNHdp2M
 wFPkwtSdNzE1Rb6lFGap8oIx69QGBtge58C7bl+QzOsykoN228MyOPpOGZ6rx6/iljDz Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 322kv6gka4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 08 Jul 2020 07:17:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06879Duc176863;
        Wed, 8 Jul 2020 07:17:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3233bqdryj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jul 2020 07:17:12 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0687HASw010537;
        Wed, 8 Jul 2020 07:17:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jul 2020 00:17:10 -0700
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 00/10] Fix a bunch SCSI related W=1 warnings
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mu4azea8.fsf@ca-mkp.ca.oracle.com>
References: <20200707140055.2956235-1-lee.jones@linaro.org>
        <159418828150.5152.12521251265216774568.b4-ty@oracle.com>
        <20200708065100.GK3500@dell>
Date:   Wed, 08 Jul 2020 03:17:08 -0400
In-Reply-To: <20200708065100.GK3500@dell> (Lee Jones's message of "Wed, 8 Jul
        2020 07:51:00 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=1 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080050
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Lee,

> Out of interest, do you know of any other efforts to fix W=1 warnings
> in SCSI?

I am not.

I try to encourage that all new patches get compiled with C=1/W=1. If I
could, I would strictly enforce this. However, there is just too much
vintage code around at this point. And even some of the most actively
developed "contemporary" drivers suffer from a large amount of sparse
warnings. Would love to see things cleaned up.

-- 
Martin K. Petersen	Oracle Linux Engineering
