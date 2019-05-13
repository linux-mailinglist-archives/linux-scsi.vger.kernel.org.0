Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB91BF8A
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 00:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEMWkW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 May 2019 18:40:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53248 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfEMWkV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 May 2019 18:40:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DMdGhQ024654;
        Mon, 13 May 2019 22:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=3XeKVO+mqNSM1TKfn5SCxIvxMkBZSp6vnjh6xKEBP/8=;
 b=va3Ganb5AZ6H8wD8VbcQoL1vpoCUArgFGwU7aRVMkEfHXpW4ZUfdpldLpL1W9H/GYhKf
 aFgwVNt+swgRVvwTu1JxCMP665FfIOey0HpG4g9Fyl3ROMi4P7feXZXNfPQ7GCqoGQdT
 bW4nFioESfpUhn8FYKMxt/shXNY5oHj6vgouWVINtFQDSN4xKu1CMEsih7L0QMeWe9jo
 vtStaLXVyBpGLSiK6RxqsH/5QU6BLebsKiR4uPcRacE9l9/vNtunWAkSpW79XlKRAIi3
 dRWHdHpScgzPVojisML9fRDjo83OsTo8zjecMzvcvz6Fu3qUxDfdDdRp1IIbUTdivP7L Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2sdq1qa2a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 22:40:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DMdMoc080612;
        Mon, 13 May 2019 22:40:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2se0tvtnt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 22:40:18 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4DMeH3F021420;
        Mon, 13 May 2019 22:40:17 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 May 2019 15:40:17 -0700
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 0/4] lpfc updated for 12.2.0.2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190507002650.23210-1-jsmart2021@gmail.com>
Date:   Mon, 13 May 2019 18:40:15 -0400
In-Reply-To: <20190507002650.23210-1-jsmart2021@gmail.com> (James Smart's
        message of "Mon, 6 May 2019 17:26:46 -0700")
Message-ID: <yq1zhnqf06o.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=710
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905130151
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=752 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130152
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


James,

> Update lpfc to revision 12.2.0.2

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
