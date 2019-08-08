Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90ACE857B0
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Aug 2019 03:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389618AbfHHBjQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Aug 2019 21:39:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42740 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389044AbfHHBjP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Aug 2019 21:39:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x781cvAg131359;
        Thu, 8 Aug 2019 01:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=GgjV8EevTSTTMAt5BF/80wJgLOTnsSzW7cE89YmaRa0=;
 b=fKeB0Pg0eY6TXjJq+QPZQn9Wk3fBAAmHox2ti/AqJ890FW6HOzJV1D96MRiNPftEjSef
 2UgzpwIMCivv2aJr0hbCNEQEYnJKVL+Pxf3ZP+PYNF/TjhOUxVwE5WeamcP5+6Lf7lXF
 YtAksbNVNj9wqN/bvRwFCg6ux+ul1UdhD7KgHEkfohX+06lfYiGQT04lE+I6T4WZvjhN
 oC5kYW7otrRjXhj74BrUVt0lnLEsuHnNPSysRHs0JGJXtL81uldy+KjGFVWwX/sto+0R
 /Bu1AfRHQTOa0w8jMO343DctUUH+do+dK2MudzThNZ6cbJsgQBXprg+b/i63heV19Fg9 Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u527pyfx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 01:39:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x781cES8023690;
        Thu, 8 Aug 2019 01:39:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2u75bx04rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 01:39:00 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x781cxbc007260;
        Thu, 8 Aug 2019 01:38:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 18:38:59 -0700
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] scsi: wd33c93: Mark expected swich fall-through
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190729210313.GA5896@embeddedor>
Date:   Wed, 07 Aug 2019 21:38:57 -0400
In-Reply-To: <20190729210313.GA5896@embeddedor> (Gustavo A. R. Silva's message
        of "Mon, 29 Jul 2019 16:03:13 -0500")
Message-ID: <yq1a7cke8r2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=671
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=728 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080014
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Gustavo,

> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warning (Building: m68k):
>
> drivers/scsi/wd33c93.c: In function =E2=80=98round_4=E2=80=99:
> drivers/scsi/wd33c93.c:1856:11: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>    case 2: ++x;
>            ^~~

Applied to 5.4/scsi-queue, thanks!

--=20
Martin K. Petersen	Oracle Linux Engineering
