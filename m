Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E161B35531
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 04:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfFECXP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 22:23:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55140 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfFECXP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 22:23:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x552E8F8048449;
        Wed, 5 Jun 2019 02:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=HCaLSPvGg2vHmQNHBj3V5nQD0tq0uhU/nxgPo/NSwkY=;
 b=1DZlNl0KTiykkRzZ6b9NkhrA+qIHPLkD/w5aZgVo+TiI3sTInrNO7WJs2RHjzks3i+rU
 rGYsQ4JpDI0Dyfos6lkWlsJVpJ0rQCqRF8dxgyxsQ9tgc8Dk3I/L2329XKO6z3C9mQBB
 mr80Rp/uFjCqnrd6Ol8cQVasJgDXU2xHMD5m/BBeaEms2bqi8rhj1aJCjV01bDXk1ELU
 swGZQR/s9p3GGRwf+beqeRX8NthgtptkMW4v5CmFoZLngUuUYo++O4nOlog9FcDxrSHw
 lpKdUviTdealBk/TAm4dChDDC67rfOdIcqDptaPHFR+oD6Eiawj00Tr+2dpUuHiQcvbD kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2suevdghyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 02:23:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x552NATM121301;
        Wed, 5 Jun 2019 02:23:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2swnghnwfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 02:23:10 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x552N8Vr013173;
        Wed, 5 Jun 2019 02:23:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 19:23:08 -0700
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Don Brace <don.brace@microsemi.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: smartpqi: unlock on error in pqi_submit_raid_request_synchronous()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190529110739.GD19119@mwanda>
Date:   Tue, 04 Jun 2019 22:23:05 -0400
In-Reply-To: <20190529110739.GD19119@mwanda> (Dan Carpenter's message of "Wed,
        29 May 2019 14:07:39 +0300")
Message-ID: <yq1v9xkrcs6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=891
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=944 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050012
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Dan,

> We need to drop the "ctrl_info->sync_request_sem" lock before returning.

Applied to 5.2/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
