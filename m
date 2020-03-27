Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F94194EB9
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Mar 2020 03:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgC0CJ5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Mar 2020 22:09:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44438 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgC0CJ5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Mar 2020 22:09:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02R29O4R093133;
        Fri, 27 Mar 2020 02:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=rxzaK+xiGUSL37btO1mXcRHCm66XoUtPIcvuddLU4dQ=;
 b=CZcI1dG2O5gWFo/ZIY08LAIe3NF1aL+GAIVKf1khvwpEMexJiuqgTUWkhxJwY2TOgrdY
 NVyv3M1VIOgn829o6/TTJjs/cfJj3PYExNAixWXcA8qKZlWg/E/1Li6UdGmgyxwMdo+m
 /gCIZ8p/Rc2JtjFEzSPR9VUXcsPl3Efv7UNZ3UtJM6WVQS2BdSfkCNZ0wFIk07zIagUs
 IHSbZf9ThXISb2+y5YTus0EsOR6MWyVP7WzWLJnV4Xk0OeEBeMy5waucBGXjL+Cf3g03
 zkMhnIBWipd8xcx9cORyDISacBVHZNDMdn4pH4H54BvS1vPBEU6Xr+Jg+kfa4H+vpv/R jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ywavmjx64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 02:09:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02R28xkD052520;
        Fri, 27 Mar 2020 02:09:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3006r9gemy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 02:09:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02R29K5N022279;
        Fri, 27 Mar 2020 02:09:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 19:09:17 -0700
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <martin.peter~sen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>, <bvanassche@acm.org>, <beanhuo@micron.com>,
        <asutoshd@codeaurora.org>, <cang@codeaurora.org>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>
Subject: Re: [PATCH v7 0/7] scsi: ufs: some cleanups and make the delay for host enabling customizable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200318104016.28049-1-stanley.chu@mediatek.com>
Date:   Thu, 26 Mar 2020 22:09:12 -0400
In-Reply-To: <20200318104016.28049-1-stanley.chu@mediatek.com> (Stanley Chu's
        message of "Wed, 18 Mar 2020 18:40:09 +0800")
Message-ID: <yq1y2rmeegn.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=996 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270015
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Stanley,

> Stanley Chu (7):
>   scsi: ufs: fix uninitialized tx_lanes in ufshcd_disable_tx_lcc()
>   scsi: ufs: use an enum for host capabilities
>   scsi: ufs: introduce common and flexible delay function
>   scsi: ufs-mediatek: use common delay function for required places
>   scsi: ufs: allow customized delay for host enabling
>   scsi: ufs: make HCE polling more compact to improve initialization latency
>   scsi: ufs-mediatek: customize the delay for host enabling

Applied to 5.7/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
