Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38B26B973
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 03:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIPBjz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 21:39:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36812 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIPBjx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Sep 2020 21:39:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G1YhpB171935;
        Wed, 16 Sep 2020 01:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Ow8rivWjzQxrCbvpH28ZaahR4f/jXedrcfDAa0gfoUA=;
 b=m/a8WC2Y7cnX2N7bt0mEVGOW5BN4UQKQaQ7EmBy5T0E5faDqKio5aw4V5hkdU7xcRJhU
 uWAV7/gEc0kuPxjq3zv6Ogta/tDCAnFKK/mvOIqPI7kcrSWBApof0+QtHxzGH2hAxsET
 9tDsZaZUEKN9/PdcXbAYrS4BPWn9NMYiVju4hHAF0QE/qkD5XBfTqRMS8GqA4z4Lx9Ow
 WhjPpX+ZpgtDKYWhg+0LgvepWBdF5sA7kMHWvVfLTfM4hM6tl7s04VLqZzGLEPNThGxz
 MO09ofQVxdVdLgU3kCc2+0nmlc8gsuulssNLmNGgifhRxdzvLpkSwwVL6kmUJBWM3q0W ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33j91dhxep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 01:37:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G1UiTI125888;
        Wed, 16 Sep 2020 01:35:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33h890dqfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 01:35:44 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08G1Zh9C013220;
        Wed, 16 Sep 2020 01:35:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 01:35:42 +0000
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <achim_leubner@adaptec.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] scsi: gdth: make option_setup() static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17dsuzeq1.fsf@ca-mkp.ca.oracle.com>
References: <20200915084033.2827009-1-yanaijie@huawei.com>
Date:   Tue, 15 Sep 2020 21:35:40 -0400
In-Reply-To: <20200915084033.2827009-1-yanaijie@huawei.com> (Jason Yan's
        message of "Tue, 15 Sep 2020 16:40:33 +0800")
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=1 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=1 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160007
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Jason,

> This addresses the following sparse warning:
>
> drivers/scsi/gdth.c:3229:12: warning: symbol 'option_setup' was not
> declared. Should it be static?

drivers/scsi/gdth.c:3229:19: error: =E2=80=98option_setup=E2=80=99 defined =
but not used [-Werror=3Dunused-function]
 3229 | static int __init option_setup(char *str)
      |                   ^~~~~~~~~~~~
cc1: all warnings being treated as errors

--=20
Martin K. Petersen	Oracle Linux Engineering
