Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03EDEC06
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 23:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfD2VZz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 17:25:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37658 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfD2VZz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 17:25:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TLK1cw075009;
        Mon, 29 Apr 2019 21:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=dnQiDuKoTpAjUaktp5D7VeYXnPPxlDPJlYNItzU/u0Y=;
 b=M3qcX8T5xFGiNdwGrb1SOQLRkT33kdh1CqPuN96c3CdWpDmQeZmcPOrrTaO8jkjE3J9d
 Tdc0eXn5DjHAqXGpg+zAsjqDeo/b6X0aEqIP23gIH4HmYzdGb707HIg5Xmir6jBnWS2x
 nGgUmjiou4W8R5IJ5iweOve/QstmOXpW/acg2/sgiWiPmDgfBe6U9SwQT04gBzEsclv5
 ZSbjYq3v8m1qJJB/neanl8ahzEmnulqXj4J2QCHbu3Z7715myOYjIc38X/P9CVAZ7MxK
 OgUcuhtdaHGO1bb7gwQRXKRjkgr5gdAr3tM9C/A24qTqiZIyYaxl2JGWnafvNyBGr59v fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s5j5twqbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 21:25:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TLPa8O101570;
        Mon, 29 Apr 2019 21:25:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2s4yy96jhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 21:25:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3TLPbhE018683;
        Mon, 29 Apr 2019 21:25:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 14:25:37 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/35] qla2xxx source code cleanup and bug fixes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190417214443.243152-1-bvanassche@acm.org>
Date:   Mon, 29 Apr 2019 17:25:29 -0400
In-Reply-To: <20190417214443.243152-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Wed, 17 Apr 2019 14:44:09 -0700")
Message-ID: <yq1muk8y052.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=859
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290138
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=902 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290138
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Bart,

> This patch series includes source code cleanup patches and also
> several bug fixes. These patches are the result of manual code
> inspection, static source code analysis and testing with lockdep and
> KASAN enabled. Please consider this patch series for kernel v5.2.

Applied to 5.2/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
