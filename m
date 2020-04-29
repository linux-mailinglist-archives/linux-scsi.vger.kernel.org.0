Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676B61BD81F
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2020 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgD2JYs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Apr 2020 05:24:48 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:6179
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbgD2JYr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Apr 2020 05:24:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+bMCiDPg/mgAPWHhwRQ5s/4+blwy1UYtC7HGdISFNRfw3KL+ZVO8hl5xGqISNp1wmAG1ZPywe1hFUD70qIeWscfaATX40FboEfX5ydZy3Ufx5noPFL4rajcyG0WfEUhfCUYVEMrBdkpnG4Yc35aSidPDSSHdKQAVi4aeHn0WKRDrfQE/lUXl2YSq3/bVweFK91xI3PGQz0P4gaKNIkRE4iK0PlQwGG5U2CKbI4oAul+oCyf4wo91mL/bdS7Gk2ygUDF29lqgqRMxYTIZEO9ZPpqJ9EOaiLOujSzluTC1dKQSWKC8NLLmBNIsQvpkUtpEjFntCEPapYlnbtQEkZ9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzoabOaO0TiRBkBbK8hkh8oyy3+5r7+tdxamy7HqhbE=;
 b=jhqXQ7xMR/eyodFRiAkFIPWZPVUC0z5ASlt6vPB6ad9KWI1ibaJe/aSKOx6t7ZKWkEZUtGASkKNnZt6311QRzNbGZfT4VhLufxbHp5tgU+KNNel/aRB30YsSLJGXe0K2JIKK3k3J2qh9XUo9tYFnNUCqi9Cstw5KtiATvTskF01SuDiiX2l4AE/Tlpj9evhrWtCeWDMsIdsEorQlP6GBbjYYR4g8RkitimPGW3St0XdKF6UfnxhcbFBgrHqXLRi0JR51bFuDeA+N4vKdCkxW87BOja4MO2u4WmWftD/cuNGhVU2rfTPjAcUt01VlM41znNv+wUynH997E6wSAgkLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzoabOaO0TiRBkBbK8hkh8oyy3+5r7+tdxamy7HqhbE=;
 b=lYU77n2pSMLYkSaMzSnD6UVLRDDjU8nettSyO+6yL1HXdDyybEJTV/o6IsYwrk3BJOHWVNhs8TS4DL+3U7jvErxNNc05BJpZbID4x8XN/Ys05Azj7nrDz7inxUTomQ1iWB7oJ5V5mZVXUP5YBdrrVMjcVeuZSCwDwr/rokI5tyg=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (2603:10b6:408:35::23)
 by BN7PR08MB4066.namprd08.prod.outlook.com (2603:10b6:406:87::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 09:24:43 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::9ca2:4625:2b46:e45c]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::9ca2:4625:2b46:e45c%4]) with mapi id 15.20.2958.020; Wed, 29 Apr 2020
 09:24:43 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>
CC:     "cang@codeaurora.org" <cang@codeaurora.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>
Subject: RE: [EXT] [PATCH v1 2/4] scsi: ufs: add "index" in parameter list of
 ufshcd_query_flag()
Thread-Topic: [EXT] [PATCH v1 2/4] scsi: ufs: add "index" in parameter list of
 ufshcd_query_flag()
Thread-Index: AQHWHU4jH0V/i/BZ5Uef47xPZgg0rKiP1SvA
Date:   Wed, 29 Apr 2020 09:24:43 +0000
Message-ID: <BN7PR08MB56849D89C8E1610A949F07AADBAD0@BN7PR08MB5684.namprd08.prod.outlook.com>
References: <20200428111355.1776-1-stanley.chu@mediatek.com>
 <20200428111355.1776-3-stanley.chu@mediatek.com>
In-Reply-To: <20200428111355.1776-3-stanley.chu@mediatek.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmVhbmh1b1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTNmZjgzMjQ4LTg5ZmItMTFlYS04YjkzLWRjNzE5NjFmOWRkM1xhbWUtdGVzdFwzZmY4MzI0YS04OWZiLTExZWEtOGI5My1kYzcxOTYxZjlkZDNib2R5LnR4dCIgc3o9Ijc2NzIiIHQ9IjEzMjMyNjI1ODgwMTU5MjcxMiIgaD0iZG9yQTFKKzlzRVFGcExkaDh5WjJ2ZVpIeUhRPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBSEFBQUFDSVNWTUNDQjdXQWNzdUVXTldpQXJ6eXk0UlkxYUlDdk1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQkFBQUFmM09FS1FBQUFBQUFBQUFBQUFBQUFBPT0iLz48L21ldGE+
x-dg-rorf: true
authentication-results: mediatek.com; dkim=none (message not signed)
 header.d=none;mediatek.com; dmarc=none action=none header.from=micron.com;
x-originating-ip: [165.225.81.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28d1bc33-e6af-4990-1bbc-08d7ec1f26db
x-ms-traffictypediagnostic: BN7PR08MB4066:|BN7PR08MB4066:|BN7PR08MB4066:
x-microsoft-antispam-prvs: <BN7PR08MB406663056A0342859D16AFB8DBAD0@BN7PR08MB4066.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR08MB5684.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(2906002)(316002)(186003)(55016002)(6506007)(9686003)(55236004)(53546011)(52536014)(110136005)(478600001)(71200400001)(4326008)(7696005)(54906003)(26005)(33656002)(8676002)(66476007)(64756008)(5660300002)(66946007)(76116006)(66556008)(7416002)(66446008)(8936002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vq4HyfomKTRO2PyxQbJojucr+3+ETjOmFlbtoeRX+fOJfTkTA1crSmb1WCrsS/JjOBL1xoJo8RnP3qVX4/daR5iQyKtgYtJpHcwEd3U3DlJT+A/J5MavwEfkurRBsqIaY6c7S9orsPfalj1R2YkRq+vWlBqZPg43sSM8xFDuvlrBIddhZIT++QVfjvyvI4rKdol93QcRFlkPUjVcm+SI5u8oUIe2qUBCxEVv/pGiHRV4fbln+zIZInuERWQpdARlaf14bbT1UGAtIcQD1KSgN+1VMWPRca2H9cKG4StPzeaXwtenbgL5rniqPHrOL6WkKrPg+TGv96nSdcdKiJiHs/xxxAkC0PieTfHGTLRmp3L+RZnh61DCFeM3Cl3dq7ULyDICGRmzIcmTqyqTrJwaAAuf0NY8HzKhX2MWIKMXSxVxdHPsdiVMlhoAeObk4Ev6
x-ms-exchange-antispam-messagedata: /je8TbsPgvWr8E0sPYV84bzU+4IqgAaWVLFAC0ci4BR1lPfIjEvF7l6LiLDtNVV+J2JoVPPHDlEZ2xzYpzIsl5ZcDKC3yCPAT8KM5XLt9slHXjGtK3P0qEV9VOPrSaDGz6tsMl1fYX3FQCZAYT/9itEXbax9TkOsHAPWIDidCdV9fbHI4uuBoJobLQ+s3eCiVr1QndHbFLBcoo9HppQH44Ja+c7hPiZ9FhRbLI0eM6hvZZ/k9FcbJwgnnAkauddYKoAqUEhha1fwU0sRBATAV6E/sQn4hsNMmCAobDKU80Ei6ceZEag/fnhXTSKCjvq1nFxTOJ01cvOePp/gps1VI2X13FFWpVijFfE/f/gMEW3q5zN/d8CTlRhCnvhRCHFmcxoGMTtMe2qCwNeun+GjDqJdopuDHUEwZIAL1AHdUJJpcHO9YqgnxVE4diGi28ZvWfL0++yfbYP8k2BVFjXpwBpD+e2pUivqx4CcvpRwep6YWUkS1txCzMjPPUQ+zW2Rnz4elYPU1XYTWNvJC3dbGNgWRR4U87/tX69jiy19E5RwCx/2aPC9LUhHu9llwmhYa911CoxRczosdkHJfBGPnHEf5fv/aESDqhCquNpLSaTHkl1SoTOHEDzBcO32qB/XBxGPUIsVmZZ+jRlnQwBCl/AWlBIhX05dPh9ImqW93LtkCyHDvSWaC0x3NmvZo6TexszUHFjhsOn+PYBMuVvjTw7R3UEJvykwglP+krpeYl+FMbOrcWbW9WorCQRGex8mpeCgN6T3OGLCqSmyiZwwtvmQf0JqFdh/Z04AMo3LVuY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d1bc33-e6af-4990-1bbc-08d7ec1f26db
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 09:24:43.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0djky35uE7hj7EpNKBAWKb2AyDfgQiJI0MXxIUcRQCCC1Bm/JCTgDq1B3vpNwx5Pq/RTGgx18k15oCdiUzeFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4066
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> -----Original Message-----
> From: Stanley Chu <stanley.chu@mediatek.com>
> Sent: Tuesday, April 28, 2020 1:14 PM
> To: linux-scsi@vger.kernel.org; martin.petersen@oracle.com;
> avri.altman@wdc.com; alim.akhtar@samsung.com; jejb@linux.ibm.com;
> asutoshd@codeaurora.org
> Cc: Bean Huo (beanhuo) <beanhuo@micron.com>; cang@codeaurora.org;
> matthias.bgg@gmail.com; bvanassche@acm.org; linux-
> mediatek@lists.infradead.org; linux-arm-kernel@lists.infradead.org; linux=
-
> kernel@vger.kernel.org; kuohong.wang@mediatek.com;
> peter.wang@mediatek.com; chun-hung.wu@mediatek.com;
> andy.teng@mediatek.com; Stanley Chu <stanley.chu@mediatek.com>
> Subject: [EXT] [PATCH v1 2/4] scsi: ufs: add "index" in parameter list of
> ufshcd_query_flag()
>=20
> For preparation of Dedicated LU support on WriteBooster feature, "index"
> parameter shall be added and allowed to be specified by callers.
>=20
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  drivers/scsi/ufs/ufs-sysfs.c |  2 +-
>  drivers/scsi/ufs/ufshcd.c    | 28 +++++++++++++++-------------
>  drivers/scsi/ufs/ufshcd.h    |  2 +-
>  3 files changed, 17 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c =
index
> 93484408bc40..b86b6a40d7e6 100644
> --- a/drivers/scsi/ufs/ufs-sysfs.c
> +++ b/drivers/scsi/ufs/ufs-sysfs.c
> @@ -631,7 +631,7 @@ static ssize_t _name##_show(struct device *dev,
> 			\
>  	struct ufs_hba *hba =3D dev_get_drvdata(dev);			\
>  	pm_runtime_get_sync(hba->dev);
> 	\
>  	ret =3D ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_READ_FLAG,
> 	\
> -		QUERY_FLAG_IDN##_uname, &flag);
> 	\
> +		QUERY_FLAG_IDN##_uname, 0, &flag);			\
>  	pm_runtime_put_sync(hba->dev);
> 	\
>  	if (ret)							\
>  		return -EINVAL;						\
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
> 111812c5304a..465ee023ea4b 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -2782,13 +2782,13 @@ static inline void ufshcd_init_query(struct ufs_h=
ba
> *hba,  }
>=20
>  static int ufshcd_query_flag_retry(struct ufs_hba *hba,
> -	enum query_opcode opcode, enum flag_idn idn, bool *flag_res)
> +	enum query_opcode opcode, enum flag_idn idn, u8 index, bool
> *flag_res)
>  {
>  	int ret;
>  	int retries;
>=20
>  	for (retries =3D 0; retries < QUERY_REQ_RETRIES; retries++) {
> -		ret =3D ufshcd_query_flag(hba, opcode, idn, flag_res);
> +		ret =3D ufshcd_query_flag(hba, opcode, idn, index, flag_res);
>  		if (ret)
>  			dev_dbg(hba->dev,
>  				"%s: failed with error %d, retries %d\n", @@ -
> 2809,16 +2809,17 @@ static int ufshcd_query_flag_retry(struct ufs_hba *hb=
a,
>   * @hba: per-adapter instance
>   * @opcode: flag query to perform
>   * @idn: flag idn to access
> + * @index: flag index to access
>   * @flag_res: the flag value after the query request completes
>   *
>   * Returns 0 for success, non-zero in case of failure
>   */
>  int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
> -			enum flag_idn idn, bool *flag_res)
> +			enum flag_idn idn, u8 index, bool *flag_res)
>  {
>  	struct ufs_query_req *request =3D NULL;
>  	struct ufs_query_res *response =3D NULL;
> -	int err, index =3D 0, selector =3D 0;
> +	int err, selector =3D 0;
>  	int timeout =3D QUERY_REQ_TIMEOUT;
>=20
>  	BUG_ON(!hba);
> @@ -4175,7 +4176,7 @@ static int ufshcd_complete_dev_init(struct ufs_hba
> *hba)
>  	bool flag_res =3D true;
>=20
>  	err =3D ufshcd_query_flag_retry(hba, UPIU_QUERY_OPCODE_SET_FLAG,
> -		QUERY_FLAG_IDN_FDEVICEINIT, NULL);
> +		QUERY_FLAG_IDN_FDEVICEINIT, 0, NULL);
>  	if (err) {
>  		dev_err(hba->dev,
>  			"%s setting fDeviceInit flag failed with error %d\n", @@
> -4186,7 +4187,7 @@ static int ufshcd_complete_dev_init(struct ufs_hba *hb=
a)
>  	/* poll for max. 1000 iterations for fDeviceInit flag to clear */
>  	for (i =3D 0; i < 1000 && !err && flag_res; i++)
>  		err =3D ufshcd_query_flag_retry(hba,
> UPIU_QUERY_OPCODE_READ_FLAG,
> -			QUERY_FLAG_IDN_FDEVICEINIT, &flag_res);
> +			QUERY_FLAG_IDN_FDEVICEINIT, 0, &flag_res);
>=20
>  	if (err)
>  		dev_err(hba->dev,
> @@ -5001,7 +5002,7 @@ static int ufshcd_enable_auto_bkops(struct ufs_hba
> *hba)
>  		goto out;
>=20
>  	err =3D ufshcd_query_flag_retry(hba, UPIU_QUERY_OPCODE_SET_FLAG,
> -			QUERY_FLAG_IDN_BKOPS_EN, NULL);
> +			QUERY_FLAG_IDN_BKOPS_EN, 0, NULL);
>  	if (err) {
>  		dev_err(hba->dev, "%s: failed to enable bkops %d\n",
>  				__func__, err);
> @@ -5051,7 +5052,7 @@ static int ufshcd_disable_auto_bkops(struct ufs_hba
> *hba)
>  	}
>=20
>  	err =3D ufshcd_query_flag_retry(hba,
> UPIU_QUERY_OPCODE_CLEAR_FLAG,
> -			QUERY_FLAG_IDN_BKOPS_EN, NULL);
> +			QUERY_FLAG_IDN_BKOPS_EN, 0, NULL);
>  	if (err) {
>  		dev_err(hba->dev, "%s: failed to disable bkops %d\n",
>  				__func__, err);
> @@ -5217,7 +5218,7 @@ static int ufshcd_wb_ctrl(struct ufs_hba *hba, bool
> enable)
>  		opcode =3D UPIU_QUERY_OPCODE_CLEAR_FLAG;
>=20
>  	ret =3D ufshcd_query_flag_retry(hba, opcode,
> -				      QUERY_FLAG_IDN_WB_EN, NULL);
> +				      QUERY_FLAG_IDN_WB_EN, 0, NULL);
>  	if (ret) {
>  		dev_err(hba->dev, "%s write booster %s failed %d\n",
>  			__func__, enable ? "enable" : "disable", ret); @@ -
> 5241,7 +5242,7 @@ static int ufshcd_wb_toggle_flush_during_h8(struct
> ufs_hba *hba, bool set)
>  		val =3D UPIU_QUERY_OPCODE_CLEAR_FLAG;
>=20
>  	return ufshcd_query_flag_retry(hba, val,
> -
> QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8,
> +
> QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8, 0,
>  				       NULL);
>  }
>=20
> @@ -5262,7 +5263,8 @@ static int ufshcd_wb_buf_flush_enable(struct ufs_hb=
a
> *hba)
>  		return 0;
>=20
>  	ret =3D ufshcd_query_flag_retry(hba, UPIU_QUERY_OPCODE_SET_FLAG,
> -				      QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN,
> NULL);
> +				      QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN,
> +				      0, NULL);
>  	if (ret)
>  		dev_err(hba->dev, "%s WB - buf flush enable failed %d\n",
>  			__func__, ret);
> @@ -5281,7 +5283,7 @@ static int ufshcd_wb_buf_flush_disable(struct ufs_h=
ba
> *hba)
>  		return 0;
>=20
>  	ret =3D ufshcd_query_flag_retry(hba,
> UPIU_QUERY_OPCODE_CLEAR_FLAG,
> -				      QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN,
> NULL);
> +				      QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN, 0,
> NULL);
>  	if (ret) {
>  		dev_warn(hba->dev, "%s: WB - buf flush disable failed %d\n",
>  			 __func__, ret);
> @@ -7254,7 +7256,7 @@ static int ufshcd_device_params_init(struct ufs_hba
> *hba)
>  	ufs_fixup_device_setup(hba);
>=20
>  	if (!ufshcd_query_flag_retry(hba, UPIU_QUERY_OPCODE_READ_FLAG,
> -			QUERY_FLAG_IDN_PWR_ON_WPE, &flag))
> +			QUERY_FLAG_IDN_PWR_ON_WPE, 0, &flag))
>  		hba->dev_info.f_power_on_wp_en =3D flag;
>=20
>  	/* Probe maximum power mode co-supported by both UFS host and
> device */ diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshc=
d.h index
> 056537e52c19..e555d794d441 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -946,7 +946,7 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,  int
> ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
>  		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val);  int
> ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
> -	enum flag_idn idn, bool *flag_res);
> +	enum flag_idn idn, u8 index, bool *flag_res);
>=20
>  void ufshcd_auto_hibern8_enable(struct ufs_hba *hba);  void
> ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
> --
> 2.18.0

Reviewed-by: Bean Huo <beanhuo@micron.com>
