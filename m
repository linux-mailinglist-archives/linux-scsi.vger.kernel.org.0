Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF9857B7
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Aug 2019 03:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389685AbfHHBlv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Aug 2019 21:41:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55956 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389583AbfHHBlv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Aug 2019 21:41:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x781cg6m054813;
        Thu, 8 Aug 2019 01:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=T5G+G1SiilFJQkhbpOIXkfEr5FWcXA7n3Y6T59N7GAE=;
 b=ZDpAdjFumfEV7oX36uL7NnLcqICjAasPhj/LgR09GHdCRXjYAEU9NHSlU4kTOh6YfhVu
 /Zci81HC07tERbRfRGlSt/uKMeL5+/49Zrr9K6GUkzldwyC8dXCoB9kJIWsBPhI/bRQ7
 10jaxU+NVNK9Q+ft61Edyf1+536Lea3qoRmc6luf0gvNDiFb7t1g5CAHwotKopWl7wuY
 TtVm5E6ZXyPaXQNvjlt6k9zJUPwOmf6+T8JeG8hRYZF+bs7MRba9zzuJZefFiprOxAY+
 M3bhHYkhFB+229Ft2736WyqLAREAbOa7mDXpl0WbLtsrbOxAs++jKwvIX1jE0zK6d/7d mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u51pu7mcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 01:41:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x781cEJG124181;
        Thu, 8 Aug 2019 01:41:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u76689ses-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 01:41:44 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x781fhm1008595;
        Thu, 8 Aug 2019 01:41:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 18:41:42 -0700
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] scsi: ufs: revamp string descriptor reading
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190730055517.32525-1-tomas.winkler@intel.com>
Date:   Wed, 07 Aug 2019 21:41:40 -0400
In-Reply-To: <20190730055517.32525-1-tomas.winkler@intel.com> (Tomas Winkler's
        message of "Tue, 30 Jul 2019 08:55:17 +0300")
Message-ID: <yq15zn8e8mj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=483
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=550 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080014
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Tomas,

> Define new a type: uc_string_id for easier string handling and less
> casting. Reduce number or string copies in price of a dynamic
> allocation.

Applied to 5.4/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
