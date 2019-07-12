Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3282E66376
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 03:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfGLBrv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 21:47:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46372 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfGLBrv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 21:47:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1ivXa138640;
        Fri, 12 Jul 2019 01:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=bOeKf0HYORGyeDkLlZkGcOq9SCXba9RpDa+uFpu0rk8=;
 b=k4aHKCd4dVUvEZD1eTuCzxtGbYythkLDYur8hiLgYTzZ+odaFkbGF+g3lKPLg+1+mDR8
 r5irxzpvl8YVSWmCOUB4eAqehIEg+Ve7C7AC261GYyYXGfYYanM6xu/858TEDEGQUJqz
 Si1PQYjlMvlACo8mdHQ7jcf+HKm3q+2gxErvsnDknlrKo2o5wGA9JoXBxOlN/e9jre26
 dV24L7zMydHRljo6LWGhPAAQmBCIEzudbhkrBjvftX9v33ZxGhUVP0Bx2D29qhENbm/a
 QlkZ+IgcH+cMIMydPuChAydfjd5cIxSreVDoPw/Lj8MQCa9X4XfSfQCxlK1kKXPddMej dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tjm9r30bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:47:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1hVnu148329;
        Fri, 12 Jul 2019 01:47:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tmwgygv1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:47:44 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6C1lgQk030476;
        Fri, 12 Jul 2019 01:47:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 18:47:42 -0700
To:     Hannes Reinecke <hare@suse.de>
Cc:     Colin King <colin.king@canonical.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: libfc: fix null pointer dereference on a null lport
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190702091835.13629-1-colin.king@canonical.com>
Date:   Thu, 11 Jul 2019 21:47:40 -0400
In-Reply-To: <20190702091835.13629-1-colin.king@canonical.com> (Colin King's
        message of "Tue, 2 Jul 2019 10:18:35 +0100")
Message-ID: <yq1h87s58hv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=863
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=933 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120020
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hannes,

Please review!

> Currently if lport is null then the null lport pointer is dereference
> when printing out debug via the FC_LPORT_DB macro. Fix this by using
> the more generic FC_LIBFC_DBG debug macro instead that does not use
> lport.

-- 
Martin K. Petersen	Oracle Linux Engineering
