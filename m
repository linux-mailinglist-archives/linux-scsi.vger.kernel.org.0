Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285FB3553D
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 04:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfFEC1m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 22:27:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58460 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfFEC1m (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 22:27:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x552ONVN054462;
        Wed, 5 Jun 2019 02:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=eWldDBxUovEpQPMWCtyJeceIu7nMSlS01A6thNYl4k4=;
 b=Mapc6Hgf38x3GFl7euAWIbDGfbX634Mrd0g0hyC1pCPKmHYp5mMrhM9RzCdlzCrfDUzx
 Fl2cs3xJadVYTK+28V12Qcg1x17aDbLLzhPDyj7ZlreTuZ0intzJJ9gXKAEfFzTjy1gU
 miz2kKKFKTWkbgKekHmhov3YzSRbHtahqq6bRUVVS//x/hFuM75dwwg3ENiABxrAwMMr
 mI5LbwTf4VS6u7hTPdP72DTUjoks+XoXdd1LduEWUpeewSqutxgAKlaYGf+vFtdNbXNQ
 c6Z8OPtOWHlxVq02UPuIkBp0KnWGVzba0JkQDEOO0mu7XG/CvEObcj4R5+B3B6lfPOCB Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2suevdgj8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 02:27:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x552Qs6i062200;
        Wed, 5 Jun 2019 02:27:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2swngknx7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 02:27:37 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x552Ra5i013588;
        Wed, 5 Jun 2019 02:27:36 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 19:27:36 -0700
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH] qla2xxx: remove double assignment in qla2x00_update_fcport
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <e5419ee1-0ae8-2d55-666e-741efece90e6@suse.de>
Date:   Tue, 04 Jun 2019 22:27:34 -0400
In-Reply-To: <e5419ee1-0ae8-2d55-666e-741efece90e6@suse.de> (Enzo Matsumiya's
        message of "Tue, 7 May 2019 12:39:05 -0300")
Message-ID: <yq1r288rckp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=885
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=931 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050013
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Enzo,

> Remove double assignment in qla2x00_update_fcport().

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
